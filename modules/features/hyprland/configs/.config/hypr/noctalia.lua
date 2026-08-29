-- Mirrors niri's noctalia-settings.kdl.

-- Your setup runs noctalia-shell as its own binary (see niri's
-- `spawn-at-startup "noctalia-shell"`), so autostart it directly rather than
-- the generic `qs -c noctalia-shell` from Noctalia's docs.
hl.on("hyprland.start", function()
    hl.exec_cmd("noctalia-shell")
end)

-- Blur for Noctalia's bar/panel backgrounds.
-- https://docs.noctalia.dev/noctalia-shell/getting-started/compositor-settings/hyprland/
hl.layer_rule({
    name = "noctalia-blur",
    match = { namespace = "noctalia-background-.*$" },
    ignore_alpha = 0.5,
    blur = true,
    blur_popups = true,
})
