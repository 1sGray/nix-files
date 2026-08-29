-- Mirrors niri's layout.kdl/animations.kdl, plus Noctalia's recommended
-- Hyprland settings:
-- https://docs.noctalia.dev/noctalia-shell/getting-started/compositor-settings/hyprland/
hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 10,
        border_size = 4,
        layout = "dwindle",
        col = {
            active_border = "rgba(7fc8ffee)",   -- niri's focus-ring active-color
            inactive_border = "rgba(505050ff)", -- niri's focus-ring inactive-color
        },
    },

    decoration = {
        rounding = 10,
        rounding_power = 2,
        active_opacity = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = 0xee1a1a1a,
        },

        -- required for the Noctalia bar/panel blur set up in noctalia.lua
        blur = {
            enabled = true,
            size = 3,
            passes = 2,
            vibrancy = 0.1696,
        },
    },

    animations = { enabled = true },
    dwindle = { preserve_split = true },
})
