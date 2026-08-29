-- Mirrors niri's window-rules.kdl.
-- https://wiki.hypr.land/Configuring/Basics/Window-Rules/

-- Float the Noctalia settings window at a fixed size — same intent as your
-- niri rule for app-id="dev.noctalia.Noctalia".
hl.window_rule({
    name = "noctalia-settings-float",
    match = { class = "dev.noctalia.Noctalia" },
    float = true,
    size = { 1080, 920 },
})

-- Your niri config also blocks KeePassXC from screen capture. Hyprland's
-- equivalent is a content-protection rule, but I didn't want to guess the
-- exact rule name for your version — check
-- https://wiki.hypr.land/Configuring/Basics/Window-Rules/ for the current
-- syntax and add it here if you want parity.
