---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = 'SUPER' -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. ' + Q', hl.dsp.exec_cmd(Terminal))
hl.bind(mainMod .. ' + C', hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)
hl.bind(mainMod .. ' + M', hl.dsp.exec_cmd "command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
hl.bind(mainMod .. ' + E', hl.dsp.exec_cmd(FileManager))
hl.bind(mainMod .. ' + V', hl.dsp.window.float { action = 'toggle' })
hl.bind(mainMod .. ' + R', hl.dsp.exec_cmd(Menu))
hl.bind(mainMod .. ' + P', hl.dsp.window.pseudo())
hl.bind(mainMod .. ' + SHIFT + J', hl.dsp.layout 'togglesplit') -- dwindle only

-- Move focus with mainMod + vim motions keys
hl.bind(mainMod .. ' + h', hl.dsp.focus { direction = 'left' })
hl.bind(mainMod .. ' + l', hl.dsp.focus { direction = 'right' })
hl.bind(mainMod .. ' + k', hl.dsp.focus { direction = 'up' })
hl.bind(mainMod .. ' + j', hl.dsp.focus { direction = 'down' })

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
  local key = i % 10 -- 10 maps to key 0
  hl.bind(mainMod .. ' + ' .. key, hl.dsp.focus { workspace = i })
  hl.bind(mainMod .. ' + SHIFT + ' .. key, hl.dsp.window.move { workspace = i })
end

-- Move window with ALT + vim motion
local function bindMoveWindow(key, side)
  hl.bind(mainMod .. ' + ALT + ' .. key, hl.dsp.window.move { direction = side })
end
bindMoveWindow('h', 'l')
bindMoveWindow('l', 'r')
bindMoveWindow('k', 'u')
bindMoveWindow('j', 'd')

local function bindResizeWindow(key, x, y)
  print 'hello'
  hl.bind(mainMod .. ' + CTRL + ' .. key, hl.dsp.window.resize { x = x, y = y, relative = true, window = 'activewindow' })
end

bindResizeWindow('l', 40, 0)
bindResizeWindow('h', -40, 0)
bindResizeWindow('k', 0, -40)
bindResizeWindow('j', 0, 40)

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. ' + mouse_down', hl.dsp.focus { workspace = 'e+1' })
hl.bind(mainMod .. ' + mouse_up', hl.dsp.focus { workspace = 'e-1' })

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. ' + mouse:272', hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. ' + mouse:273', hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind('XF86AudioRaiseVolume', hl.dsp.exec_cmd '~/.config/hypr/scripts/volume.sh inc', { locked = true, repeating = true })
hl.bind('XF86AudioLowerVolume', hl.dsp.exec_cmd ' ~/.config/hypr/scripts/volume.sh dec', { locked = true, repeating = true })
hl.bind('XF86AudioMute', hl.dsp.exec_cmd '~/.config/hypr/scripts/volume.sh mute', { locked = true, repeating = true })
hl.bind('XF86AudioMicMute', hl.dsp.exec_cmd 'wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle', { locked = true, repeating = true })
hl.bind('XF86MonBrightnessUp', hl.dsp.exec_cmd '~/.config/hypr/scripts/brightness.sh inc', { locked = true, repeating = true })
hl.bind('XF86MonBrightnessDown', hl.dsp.exec_cmd '~/.config/hypr/scripts/brightness.sh dec', { locked = true, repeating = true })

-- Requires playerctl
hl.bind('XF86AudioNext', hl.dsp.exec_cmd 'playerctl next', { locked = true })
hl.bind('XF86AudioPause', hl.dsp.exec_cmd 'playerctl play-pause', { locked = true })
hl.bind('XF86AudioPlay', hl.dsp.exec_cmd 'playerctl play-pause', { locked = true })
hl.bind('XF86AudioPrev', hl.dsp.exec_cmd 'playerctl previous', { locked = true })

hl.bind(mainMod .. ' + SHIFT + l', hl.dsp.exec_cmd 'hyprlock')
hl.bind(mainMod .. ' + SHIFT + f', hl.dsp.window.fullscreen { mode = 'fullscreen', window = 'activewindow' })
hl.bind(mainMod .. '+ f', hl.dsp.window.fullscreen { mode = 'maximized', window = 'activewindow' })
