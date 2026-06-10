-------------------
---- AUTOSTART ----
------------------
-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
hl.on('hyprland.start', function()
  hl.exec_cmd 'systemctl --user start hyprpolkitagent'
  hl.exec_cmd 'wl-paste --type text --watch cliphist store'
  hl.exec_cmd 'wl-paste --type image --watch cliphist store'
  hl.exec_cmd 'waybar'
  -- https://gist.github.com/brunoanc/2dea6ddf6974ba4e5d26c3139ffb7580
  hl.exec_cmd 'dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP'
  hl.exec_cmd 'hyprpaper'
  hl.exec_cmd 'hypridle'
  hl.exec_cmd 'nm-applet'
  hl.dispatch(hl.dsp.focus { workspace = 1 })
end)
