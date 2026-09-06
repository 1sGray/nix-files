-- This starts Noctalia (v5)
hl.on("hyprland.start", function()
    hl.exec_cmd("noctalia")
end)

-- -- This starts noctalia-shell (v4)
-- hl.on("hyprland.start", function()
--     hl.exec_cmd("noctalia-shell")
-- end)

-- Blur for Noctalia's bar/panel backgrounds.
-- https://docs.noctalia.dev/noctalia-shell/getting-started/compositor-settings/hyprland/
hl.layer_rule({
    name = "noctalia-blur",
    match = { namespace = "noctalia-background-.*$" },
    ignore_alpha = 0.5,
    blur = true,
    blur_popups = true,
})
