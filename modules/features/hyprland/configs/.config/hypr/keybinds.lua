-- Mirrors niri's keybinds.kdl. Noctalia is driven identically in both
-- compositors: `noctalia-shell ipc call <category> <action>`.
--
-- The Lua dispatcher API is new as of Hyprland 0.55 — shapes below come from
-- Hyprland's own example config, but a couple (marked below) are inferred
-- from that naming pattern rather than directly confirmed. Check
-- https://wiki.hypr.land/Configuring/Dispatchers/ if one doesn't fire.

local mainMod = "SUPER"
local ipc = "noctalia-shell ipc call "

--================================================================================
-- General
--================================================================================

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exit()) -- inferred name, verify

--================================================================================
-- Noctalia
--================================================================================

hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd(ipc .. "launcher toggle"))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd(ipc .. "controlCenter toggle"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(ipc .. "settings toggle"))
hl.bind("ALT + Tab", hl.dsp.exec_cmd(ipc .. "windowSwitcher toggle"))
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd(ipc .. "lockScreen lock"))
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd(ipc .. "sessionMenu toggle"))
hl.bind(mainMod .. " + grave", hl.dsp.exec_cmd(ipc .. "plugin:keybind-cheatsheet toggle"))

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(ipc .. "volume increase"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(ipc .. "volume decrease"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(ipc .. "volume mute"), { locked = true })

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(ipc .. "brightness increase"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(ipc .. "brightness decrease"), { locked = true, repeating = true })

--================================================================================
-- Windows
--================================================================================

hl.bind(mainMod .. " + Left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + Right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + Up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + Down",  hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))

hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen()) -- inferred name, verify

--================================================================================
-- Workspaces (Ctrl to move, matching your niri Mod+Ctrl+N convention)
--================================================================================

for i = 1, 9 do
    hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + CTRL + " .. i, hl.dsp.window.move({ workspace = i }))
end

--================================================================================
-- Mouse move/resize
--================================================================================

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
