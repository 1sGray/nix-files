-- Mirrors niri's inputs.kdl. https://wiki.hypr.land/Configuring/Variables/#input
hl.config({
    input = {
        kb_layout = "us",
        numlock_by_default = true,
        follow_mouse = 1,

        -- mirrors niri's mouse { accel-speed -0.3; accel-profile flat }
        sensitivity = -0.3,
        accel_profile = "flat",

        touchpad = {
            -- mirrors niri's touchpad { tap; natural-scroll; accel-speed 0.2 }
            natural_scroll = true,
            ["tap-to-click"] = true,
        },
    },
})

-- Hyprland doesn't have a single "touchpad accel-speed" like niri — it's
-- scoped per input device. Find yours with `hyprctl devices` and add:
-- hl.device({ name = "your-touchpad-name", sensitivity = 0.2 })
