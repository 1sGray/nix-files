-- Mirrors niri's keybinds.kdl. Noctalia is driven identically in both
-- compositors: `noctalia-shell ipc call <category> <action>`.
--
-- The Lua dispatcher API is new as of Hyprland 0.55 — shapes below come from
-- Hyprland's own example config, but a couple (marked below) are inferred
-- from that naming pattern rather than directly confirmed. Check
-- https://wiki.hypr.land/Configuring/Dispatchers/ if one doesn't fire.

local mainMod = "SUPER"
local ipc = "noctalia-shell ipc call "

-- Per-layout binds function ==============================================================
-- local function layout_bind(bind_table)
--     return function ()
--         local workspace = hl.get_active_special_workspace() or
--                           hl.get_active_workspace()
--
--         if not workspace then
--             return
--         end
--
--         local layout = workspace.tiled_layout
--
--         if bind_table[layout] then
--             hl.dispatch(bind_table[layout])
--         end
--     end
-- end

--================================================================================
-- General
--================================================================================

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd("kitty"))

-- Quit Hyprland. It’s recommended to use hyprshutdown instead ================================================================================
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("hyprshutdown")) -- Quit Hyprland properly
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exit()) -- Quit Hyprland

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

-- hl.bind(mainMod .. " + ", hl.dsp.window.float({ action = "toggle" }))
-- General ================================================================================
hl.bind(mainMod .. " + Q", hl.dsp.window.close()) -- Send a graceful request to close the window.
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.kill()) -- Kill the process owning the window with a SIGKILL.

--================================================================================
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))

-- Set a window’s fullscreen state ===========================================================================
-- mode can be “maximized” and “fullscreen”.
-- action can be toggle/set/unset.
-- layout_aware takes true(default)/false, allows you to choose if you want to use layout- or default-handled fullscreen behavior.
hl.bind(mainMod .. " + M", hl.dsp.window.fullscreen( {action = "toggle", mode = "maximized", layout_aware = true,} )) -- inferred name, verify
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen( {action = "toggle", mode = "fullscreen", layout_aware = true,} )) -- inferred name, verify

hl.bind(mainMod .. " + C", hl.dsp.layout("center")) -- Centers the currently focused column.

-- Move the focus in a direction ================================================================================
hl.bind(mainMod .. " + Left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + Right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + Up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + Down",  hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))

-- Move a window in a direction ================================================================================
hl.bind(mainMod .. " + CTRL + Left",  hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + CTRL + Right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + CTRL + Up",    hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + CTRL + Down",  hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + CTRL + H",     hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + CTRL + J",     hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + CTRL + K",     hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + CTRL + L",     hl.dsp.window.move({ direction = "right" }))

-- Move a window to a workspace ================================================================================

for i = 1, 9 do
    hl.bind(mainMod .. " + CTRL + " .. i, hl.dsp.window.move({ workspace = i }))
end

-- Resize a window ================================================================================

hl.bind(mainMod .. " + minus", hl.dsp.window.resize({ x = 10, y = 0, relative = true, }))
hl.bind(mainMod .. " + SHIFT + minus", hl.dsp.window.resize({ x = -10, y = 0,relative = true }))

hl.bind(mainMod .. " + equal", hl.dsp.window.resize({ x = 0, y = 10, relative = true, }))
hl.bind(mainMod .. " + SHIFT + equal", hl.dsp.window.resize({ x = 0, y = -10,relative = true }))

--================================================================================
-- Workspaces
--================================================================================

for i = 1, 9 do
    hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
end

--================================================================================
-- Workspaces
--================================================================================
--================================================================================
-- Mouse 
--================================================================================

-- move/resize ================================================================================
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

--================================================================================
-- Trackpad
--================================================================================
hl.gesture({ fingers = 3, direction = "horizontal", scale = 1.5, action = "scroll_move" })
hl.gesture({ fingers = 3, direction = "vertical", action = "workspace" })
