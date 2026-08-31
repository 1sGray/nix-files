-- Starting SSH
hl.on("hyprland.start", function ()
    hl.env("SSH_AUTH_SOCK", os.getenv("XDG_RUNTIME_DIR").."/ssh-agent.socket")
end)
