-- Session/systemd bootstrap.
--
-- start-hyprland does NOT import the compositor's environment into the
-- systemd --user session or start graphical-session.target (confirmed via
-- `strings` on the binary — no systemctl/dbus-update-activation-environment
-- calls anywhere in it). Without this, everything that depends on that
-- target — xdg-desktop-portal, gvfs-daemon, gcr-ssh-agent.socket, etc. —
-- stays dead for the whole session. That's why the portal fix alone did
-- nothing: there was no live systemd session for it to attach to.
--
-- Hyprland's own docs point to UWSM as the fully-supported fix for this;
-- this is the minimal equivalent without adopting a separate session manager.
--
hl.on("hyprland.start", function()
    hl.exec_cmd(
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP HYPRLAND_INSTANCE_SIGNATURE"
        .. " && dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP HYPRLAND_INSTANCE_SIGNATURE"
        .. " && systemctl --user start hyprland-session.target"
    )
end)
