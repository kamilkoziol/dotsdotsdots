# dotsdotsdots
It contains... well, dots.

## System setup (Arch)
Things outside `~/.config` that this config expects. Run once per machine.

### Packages
```sh
sudo pacman -S grim slurp satty wf-recorder cliphist \
  brightnessctl playerctl pavucontrol network-manager-applet thunar mpv \
  calcurse htop blueman bluez bluez-utils \
  udisks2 udiskie gvfs gvfs-mtp tumbler \
  tlp ufw xdg-user-dirs \
  noto-fonts noto-fonts-emoji \
  starship uv pyenv tree ripgrep jq tmux wget rtkit \
  neovim gcc make unzip tree-sitter-cli fd wl-clipboard \
  base-devel openssl zlib xz tk \
  webp-pixbuf-loader libavif \
  libreoffice-fresh hunspell-pl hunspell-en_us thunderbird \
  networkmanager-openvpn gnome-keyring
yay -S nvm pyenv-virtualenv visual-studio-code-bin
sudo systemctl enable --now bluetooth
```

### Node (nvm) and Python (pyenv)
Data lives in `~/.local/share/{nvm,pyenv}`, set in `zsh/.zshrc`.
```sh
nvm install --lts
nvm alias default 'lts/*'
pyenv install 3.14
pyenv global 3.14
```

### Neovim
Open `nvim` once: lazy installs plugins, mason installs LSPs/formatters. Check with `:Lazy`, `:Mason`, `:checkhealth`.

### tmux
Set up the GitHub SSH key first (`git/config` rewrites GitHub URLs to SSH). Start `tmux` once: tpm clones itself to `tmux/plugins/tpm` and installs plugins. Update with `prefix + U`.

### Untracked config (copy by hand)
Not in the repo (passwords, tokens, mail). Copy from the old machine:
- `~/.config/thunderbird`
- `~/.config/claude` (only `CLAUDE.md` and `settings.json` are tracked)
- `~/.config/Code/User`
- `~/.ssh`

### Hyprland user services
```sh
systemctl --user enable hypridle hyprpaper hyprpolkitagent
```

### Login manager (ly)
```sh
sudo pacman -S ly
sudo systemctl disable getty@tty2.service
sudo systemctl enable ly@tty2.service
```
Pick the `Hyprland` session (←/→), not `Hyprland (uwsm-managed)`.

ly unlocks the keyring at login only if it is named `login` and uses the login password. When an app asks to create a keyring, name it `login` and give it the login password.

### XDG user dirs and dark mode
```sh
xdg-user-dirs-update
gsettings set org.gnome.desktop.interface color-scheme prefer-dark
```

### Battery (TLP, charge 40-80%)
Thresholds live in `tlp/10-battery.conf`; `/etc/tlp.d` links to it.
```sh
sudo ln -s ~/.config/tlp/10-battery.conf /etc/tlp.d/10-battery.conf
sudo systemctl mask systemd-rfkill.service systemd-rfkill.socket
sudo systemctl enable --now tlp
```
Check: `tlp-stat -c | grep THRESH`, `cat /sys/class/power_supply/BAT0/charge_control_*_threshold`.

### DNS (systemd-resolved)
```sh
printf '[main]\ndns=systemd-resolved\n' | sudo tee /etc/NetworkManager/conf.d/dns.conf
sudo systemctl enable --now systemd-resolved
sudo ln -sf ../run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
sudo systemctl restart NetworkManager
```
Check: `resolvectl status`.

### Firewall (ufw, all incoming closed)
```sh
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw enable
sudo systemctl enable ufw
```
Check: `sudo ufw status verbose`.

### Containers (rootless Podman)
```sh
sudo pacman -S podman
```
Check: `grep kamil /etc/subuid`, `podman info | grep rootless`.

### Fingerprint (t16 only)
```sh
fprintd-enroll
sudo sed -i '1a auth\t\tsufficient\tpam_fprintd.so' /etc/pam.d/sudo
sudo cp /usr/lib/pam.d/polkit-1 /etc/pam.d/polkit-1
sudo sed -i '1a auth\t\tsufficient\tpam_fprintd.so' /etc/pam.d/polkit-1
```
Not in `system-auth`/`login`: hyprlock does fingerprint itself (`hypr/profiles/t16/hyprlock.conf`).
