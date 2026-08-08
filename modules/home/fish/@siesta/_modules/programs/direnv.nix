{ ... }: {
  # nixpkgs.overlays = [
  #   (self: super: {
  #     nix-direnv = super.nix-direnv.override {
  #       nix = super.nix-monitored;
  #     };
  #   })
  # ];
  programs = {
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
