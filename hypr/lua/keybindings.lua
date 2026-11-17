---------------------
---- KEYBINDINGS ----
---------------------

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(MainMod .. ' + Q', hl.dsp.exec_cmd(Terminal))
hl.bind(MainMod .. ' + C', hl.dsp.window.close())
hl.bind(MainMod .. ' + M', hl.dsp.exec_cmd "command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
hl.bind(MainMod .. ' + E', hl.dsp.exec_cmd(FileManager))
hl.bind(MainMod .. ' + V', hl.dsp.window.float { action = 'toggle' })
hl.bind(MainMod .. ' + SHIFT + v', hl.dsp.exec_cmd 'cliphist list | wofi --dmenu | cliphist decode | wl-copy')
hl.bind(MainMod .. ' + R', hl.dsp.exec_cmd(Menu))
hl.bind(MainMod .. ' + P', hl.dsp.window.pseudo())
hl.bind(MainMod .. ' + SHIFT + J', hl.dsp.layout 'togglesplit') -- dwindle only

-- Move focus with mainMod + vim motions keys
hl.bind(MainMod .. ' + h', hl.dsp.focus { direction = 'left' })
hl.bind(MainMod .. ' + l', hl.dsp.focus { direction = 'right' })
hl.bind(MainMod .. ' + k', hl.dsp.focus { direction = 'up' })
hl.bind(MainMod .. ' + j', hl.dsp.focus { direction = 'down' })

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
  local key = i % 10 -- 10 maps to key 0
  hl.bind(MainMod .. ' + ' .. key, hl.dsp.focus { workspace = i })
  hl.bind(MainMod .. ' + SHIFT + ' .. key, hl.dsp.window.move { workspace = i })
end

-- Move window with ALT + vim motion
local function bindMoveWindow(key, side)
  hl.bind(MainMod .. ' + ALT + ' .. key, hl.dsp.window.move { direction = side })
end
bindMoveWindow('h', 'l')
bindMoveWindow('l', 'r')
bindMoveWindow('k', 'u')
bindMoveWindow('j', 'd')

local function bindResizeWindow(key, x, y)
  hl.bind(MainMod .. ' + CTRL + ' .. key, hl.dsp.window.resize { x = x, y = y, relative = true, window = 'activewindow' })
end

bindResizeWindow('l', 40, 0)
bindResizeWindow('h', -40, 0)
bindResizeWindow('k', 0, -40)
bindResizeWindow('j', 0, 40)

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(MainMod .. ' + mouse_down', hl.dsp.focus { workspace = 'e+1' })
hl.bind(MainMod .. ' + mouse_up', hl.dsp.focus { workspace = 'e-1' })

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(MainMod .. ' + mouse:272', hl.dsp.window.drag(), { mouse = true })
hl.bind(MainMod .. ' + mouse:273', hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind('XF86AudioRaiseVolume', hl.dsp.exec_cmd '~/.config/hypr/scripts/volume.sh inc', { locked = true, repeating = true })
hl.bind('XF86AudioLowerVolume', hl.dsp.exec_cmd '~/.config/hypr/scripts/volume.sh dec', { locked = true, repeating = true })
hl.bind('XF86AudioMute', hl.dsp.exec_cmd '~/.config/hypr/scripts/volume.sh mute', { locked = true })
hl.bind('XF86AudioMicMute', hl.dsp.exec_cmd 'wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle', { locked = true })
hl.bind('XF86MonBrightnessUp', hl.dsp.exec_cmd '~/.config/hypr/scripts/brightness.sh inc', { locked = true, repeating = true })
hl.bind('XF86MonBrightnessDown', hl.dsp.exec_cmd '~/.config/hypr/scripts/brightness.sh dec', { locked = true, repeating = true })

-- Requires playerctl
hl.bind('XF86AudioNext', hl.dsp.exec_cmd 'playerctl next', { locked = true })
hl.bind('XF86AudioPause', hl.dsp.exec_cmd 'playerctl play-pause', { locked = true })
hl.bind('XF86AudioPlay', hl.dsp.exec_cmd 'playerctl play-pause', { locked = true })
hl.bind('XF86AudioPrev', hl.dsp.exec_cmd 'playerctl previous', { locked = true })

hl.bind(MainMod .. ' + SHIFT + l', hl.dsp.exec_cmd 'hyprlock')
hl.bind(MainMod .. ' + SHIFT + f', hl.dsp.window.fullscreen { mode = 'fullscreen', window = 'activewindow' })
hl.bind(MainMod .. ' + f', hl.dsp.window.fullscreen { mode = 'maximized', window = 'activewindow' })

local shot = '~/.config/hypr/scripts/screenshot.sh '
hl.bind('Print', hl.dsp.exec_cmd(shot .. 'region'))
hl.bind(MainMod .. ' + SHIFT + s', hl.dsp.exec_cmd(shot .. 'region'))
hl.bind('SHIFT + Print', hl.dsp.exec_cmd(shot .. 'full'))
hl.bind(MainMod .. ' + SHIFT + w', hl.dsp.exec_cmd(shot .. 'window'))
hl.bind('ALT + Print', hl.dsp.exec_cmd(shot .. 'record'))

hl.bind(MainMod .. ' + g', hl.dsp.submap 'group')

hl.define_submap('group', 'reset', function()
  hl.bind('g', hl.dsp.group.toggle { window = 'active' })
  hl.bind('x', hl.dsp.window.move { out_of_group = true })
  hl.bind('n', hl.dsp.group.move_window { window = 'active', forward = true })
  hl.bind('p', hl.dsp.group.move_window { window = 'active', forward = false })
  hl.bind('1', hl.dsp.group.active { index = 1 })
  hl.bind('2', hl.dsp.group.active { index = 2 })
  hl.bind('3', hl.dsp.group.active { index = 3 })
  hl.bind('4', hl.dsp.group.active { index = 4 })
  hl.bind('5', hl.dsp.group.active { index = 5 })
  hl.bind('h', hl.dsp.window.move { window = 'active', into_or_create_group = 'l' })
  hl.bind('j', hl.dsp.window.move { window = 'active', into_or_create_group = 'd' })
  hl.bind('k', hl.dsp.window.move { window = 'active', into_or_create_group = 'u' })
  hl.bind('l', hl.dsp.window.move { window = 'active', into_or_create_group = 'r' })
  hl.bind('ESCAPE', hl.dsp.submap 'reset')
end)
