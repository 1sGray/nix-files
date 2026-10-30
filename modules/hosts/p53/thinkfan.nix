{ self, inputs, ... }: {
  flake.nixosModules.thinkfan = { pkgs, lib, ... }: {

    # Lets userspace (thinkfan) take over fan control from the EC
    boot.extraModprobeConfig = ''
      options thinkpad_acpi fan_control=1
    '';

    services.thinkfan = {
      enable = true;
      # each entry: [ fan-level  lower-temp  upper-temp ]
      # it steps up past upper-temp and back down below lower-temp
      levels = [
        [ 0 0  55 ]
        [ 1 50 60 ]
        [ 2 55 65 ]
        [ 3 60 70 ]
        [ 4 65 75 ]
        [ 5 70 80 ]
        [ 7 75 32767 ]   # 7 = "disengaged" (full speed)
      ];
    };
  };
}
