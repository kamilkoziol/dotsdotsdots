---------------------
---- MY PROGRAMS ----
---------------------
MainMod = 'SUPER' -- Sets "Windows" key as main modifier
Terminal = 'kitty'
FileManager = 'thunar'
Menu = 'wofi --show drun'

------------------
--- MONITORS ----
------------------
require 'profiles.current.hyprmonitors'

require 'lua.autostart'

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/
hl.env('XCURSOR_SIZE', '24')
hl.env('HYPRCURSOR_SIZE', '24')
hl.env('EDITOR', 'nvim')
hl.env('VISUAL', 'nvim')
hl.env('CLAUDE_CONFIG_DIR', os.getenv('HOME') .. '/.config/claude')

require 'profiles.current.hyprenvs'
require 'lua.look_and_feel'
require 'lua.curves'

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config {
  dwindle = {
    preserve_split = true, -- You probably want this
    force_split = 2,
    special_scale_factor = 0.95,
  },
}

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config {
  master = {
    new_status = 'master',
  },
}

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config {
  scrolling = {
    fullscreen_on_one_column = true,
  },
}

----------------
----  MISC  ----
----------------

hl.config {
  misc = {
    force_default_wallpaper = 1, -- Set to 0 or 1 to disable the anime mascot wallpapers
    disable_hyprland_logo = true, -- If true disables the random hyprland logo / anime girl background. :(
  },
}

---------------
---- INPUT ----
---------------

hl.config {
  input = {
    kb_layout = 'pl',
    kb_variant = '',
    kb_model = '',
    kb_options = '',
    kb_rules = '',

    follow_mouse = 1,

    sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

    touchpad = {
      natural_scroll = true,
    },
  },
}

hl.gesture {
  fingers = 3,
  direction = 'horizontal',
  action = 'workspace',
}

require 'lua.keybindings'

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

hl.window_rule {
  -- Ignore maximize requests from all apps. You'll probably like this.
  name = 'suppress-maximize-events',
  match = { class = '.*' },

  suppress_event = 'maximize',
}

hl.window_rule {
  -- Fix some dragging issues with XWayland
  name = 'fix-xwayland-drags',
  match = {
    class = '^$',
    title = '^$',
    xwayland = true,
    float = true,
    fullscreen = false,
    pin = false,
  },

  no_focus = true,
}

-- Hyprland-run windowrule
hl.window_rule {
  name = 'move-hyprland-run',
  match = { class = 'hyprland-run' },

  move = '20 monitor_h-120',
  float = true,
}

hl.window_rule { name = 'fullscreen-window-no-border', match = { fullscreen = true }, border_size = 0 }

hl.workspace_rule {
  workspace = 'f[1]',
  gaps_out = 5,
}
