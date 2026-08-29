-- PRIME/GPU env vars — the aquamarine-backend equivalent of your niri PRIME
-- setup. Paths below are derived from your existing bus IDs in
-- generalConfiguration.nix (intelBusId "PCI:0@0:2:0", nvidiaBusId
-- "PCI:1@0:0:0" -> 0000:00:02.0 / 0000:01:00.0). iGPU listed first = primary.
-- Confirm the symlinks exist first: `ls -la /dev/dri/by-path/`
hl.env(
      "AQ_DRM_DEVICES",
      "/dev/dri/card-intel:/dev/dri/card-nvidia"
)

hl.env("XCURSOR_SIZE", "24")

-- VA-API: default to the Intel driver (works everywhere, including Brave).
-- nvidia-vaapi-driver has known problems with Chromium, so it's opt-in per
-- app rather than the session default:
--   LIBVA_DRIVER_NAME=nvidia mpv some-file.mkv
hl.env("LIBVA_DRIVER_NAME", "iHD")
