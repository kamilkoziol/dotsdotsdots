-- ################
-- ### MONITORS ###
-- ################

-- # See https://wiki.hypr.land/Configuring/Monitors/
-- monitor = DP-2, 2560x1440@144, 0x0, 1
-- monitor = HDMI-A-1, 1920x1080, -1920x300, 1
hl.monitor { output = 'DP-2', mode = '2560x1440@144', position = '0x0', scale = 1 }
hl.monitor { output = 'HDMI-A-1', mode = '1920x1080', position = '-1920x300', scale = 1 }
--
-- workspace = 1, monitor:DP-2
hl.workspace_rule { workspace = '1', monitor = 'DP-2' }
-- workspace = 2, monitor:DP-2
hl.workspace_rule { workspace = '2', monitor = 'DP-2' }
-- workspace = 3, monitor:DP-2
hl.workspace_rule { workspace = '3', monitor = 'DP-2' }
-- workspace = 4, monitor:DP-2
hl.workspace_rule { workspace = '4', monitor = 'DP-2' }
-- workspace = 5, monitor:HDMI-A-1
hl.workspace_rule { workspace = '5', monitor = 'HDMI-A-1' }
-- workspace = 6, monitor:HDMI-A-1
hl.workspace_rule { workspace = '6', monitor = 'HDMI-A-1' }
--
hl.bind('SUPER + SHIFT + p', hl.dsp.window.move { monitor = '+1', window = 'activewindow' })
