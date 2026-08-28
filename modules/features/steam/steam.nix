{ self, inputs, ... }: {
	
	flake.nixosModules.steam = { pkgs, lib, ... }: {

        # programs.steam = {
        #
        #     enable = true;
        #
        #     protontricks.enable = true;
        #
        #     extraCompatPackages = with pkgs; [
        #         proton-ge-bin
        #     ];
        #
        #     package = pkgs.steam.override {
        #         extraEnv = {
        #             __GLX_VENDOR_LIBRARY_NAME = "nvidia";
        #             __NV_PRIME_RENDER_OFFLOAD = "1";
        #             __NV_PRIME_RENDER_OFFLOAD_PROVIDER = "NVIDIA-G0";
        #             __VK_LAYER_NV_optimus = "NVIDIA_only";
        #         };
        #     };
        #
        # };

        hardware.graphics.enable32Bit = true;
    };

	# perSystem = { pkg , lib, ... }: {};
}
