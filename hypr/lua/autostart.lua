-------------------
---- AUTOSTART ----
------------------
-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
hl.on('hyprland.start', function()
  hl.exec_cmd 'wl-paste --type text --watch cliphist store'
  hl.exec_cmd 'wl-paste --type image --watch cliphist store'
  hl.exec_cmd 'waybar'
  hl.exec_cmd 'nm-applet'
  hl.exec_cmd 'udiskie'
  hl.dispatch(hl.dsp.focus { workspace = 1 })
end)
