{ self, inputs, ... }: {

  flake.nixosModules.p53Graphics = { pkgs, lib, config, ... }: {
    
    boot.initrd.kernelModules = [ "i915" ]; # early KMS font fix

    #Xorg drivers (needed even w/o xorg & on Wayland): "modesetting" handles the Intel iGPU, "nvidia" is required of dGPU
    services.xserver.videoDrivers = [ "modesetting" "nvidia" ];

    hardware.graphics.enable = true; # OpenGL/Vulkan userspace support

    hardware.nvidia = {
      modesetting.enable = true; # required for offload - otherwise Xorg runs permanently on the dGPU and it never sleeps
      open = false; # properietary kernel module - most mature/well tested path for Turing class cards like T1000
      package = config.boot.kernelPackages.nvidiaPackages.stable;

      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true; # gives you a `nvidia-offload` wrapper command
        };

        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
      
    };

  };

}
