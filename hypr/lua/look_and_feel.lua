-----------------------
---- LOOK AND FEEL ----
-----------------------
-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config {
  general = {
    gaps_in = 5,
    gaps_out = 10,

    border_size = 1,

    col = {
      active_border = 'rgb(cba6f7)',
      inactive_border = 'rgb(181825)',
    },

    -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
    resize_on_border = false,

    -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
    allow_tearing = false,

    layout = 'dwindle',
  },

  decoration = {
    rounding = 0,

    -- Change transparency of focused and unfocused windows
    active_opacity = 1.0,
    inactive_opacity = 1.0,

    shadow = {
      enabled = true,
      range = 4,
      render_power = 3,
      color = 0xee1a1a1a,
    },

    blur = {
      enabled = false,
      size = 3,
      passes = 1,
      vibrancy = 0.1696,
    },
  },

  animations = {
    enabled = true,
  },
}

hl.config {
  group = {
    col = {
      border_active = 'rgb(cba6f7)',
      border_inactive = 'rgb(181825)',
      border_locked_active = 'rgb(f5c2e7)',
      border_locked_inactive = 'rgb(181825)',
    },

    groupbar = {
      font_family = 'Hack Nerd Font Mono',
      font_size = 12,
      font_weight_active = 'bold',
      font_weight_inactive = 'bold',
      text_padding = 22,
      height = 16,
      indicator_height = 2,
      col = {
        active = 'rgb(cba6f7)',
        inactive = 'rgb(313244)',
        locked_active = 'rgb(f5c2e7)',
        locked_inactive = 'rgb(313244)',
      },
      text_color = 'rgb(11111b)',
      text_color_inactive = 'rgb(a6adc8)',
    },
  },
}
