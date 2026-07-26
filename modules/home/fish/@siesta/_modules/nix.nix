{ inputs, ... }: {
  # nix.nixPath = [ "nvf=${inputs.nvf}" ];
  home.sessionVariables = {
    NIX_PATH = "$NIX_PATH:nvf=${inputs.nvf}";
  };
}
