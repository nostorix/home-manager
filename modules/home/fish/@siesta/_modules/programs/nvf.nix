{
  self,
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
  programs.nvf = {
    defaultEditor = true;
    enable = true;
    settings = {
      imports = [
        inputs.substratum.nvf.config
      ];
      vim = {
        lsp = {
          servers = {
            nixd = {
              settings = {
                nixd = {
                  options = {
                    home_manager = {
                      expr = ''
                        let
                          flakePath = ./.;
                          flake = if builtins.pathExists(flakePath+"/flake.nix")
                                    then builtins.getFlake(toString flakePath)
                                    else {};
                          options =
                            if flake ? homeConfigurations
                               && flake.homeConfigurations ? ${config.home.username}
                            then flake.homeConfigurations.${config.home.username}.options
                            else 
                            if flake ? legacyPackages
                               && flake.legacyPackages ? ${pkgs.stdenv.hostPlatform.system} 
                               && flake.legacyPackages.${pkgs.stdenv.hostPlatform.system} ? homeConfigurations 
                               && flake.legacyPackages.${pkgs.stdenv.hostPlatform.system}.homeConfigurations ? ${config.home.username} 
                            then flake.legacyPackages.${pkgs.stdenv.hostPlatform.system}.homeConfigurations.${config.home.username}.options
                            else
                            if flake ? legacyPackages
                               && flake.legacyPackages ? ${pkgs.stdenv.hostPlatform.system} 
                               && flake.legacyPackages.${pkgs.stdenv.hostPlatform.system} ? homeConfigurations 
                               && flake.legacyPackages.${pkgs.stdenv.hostPlatform.system}.homeConfigurations ? "${config.home.username}@siesta"
                            then flake.legacyPackages.${pkgs.stdenv.hostPlatform.system}.homeConfigurations."${config.home.username}@siesta".options 
                            else
                            {};
                        in
                          options
                      '';
                    };
                    nixos = {
                      expr = ''
                        let
                          flakePath = ./.;
                          flake = if builtins.pathExists(flakePath+"/flake.nix")
                                    then builtins.getFlake(toString flakePath)
                                    else {};
                          options =
                            if flake ? nixosConfigurations
                               && flake.nixosConfigurations ? siesta
                            then flake.nixosConfigurations.siesta.options
                            else {};
                        in
                          options
                      '';
                    };
                    finix = {
                      expr = ''
                        let
                          flakePath = ./.;
                          flake = if builtins.pathExists(flakePath+"/flake.nix")
                                    then builtins.getFlake(toString flakePath)
                                    else {};
                          options =
                            if flake ? nixosConfigurations
                               && flake.nixosConfigurations ? vane
                            then flake.homeConfigurations.vane.options
                            else 
                            if flake ? legacyPackages
                               && flake.legacyPackages ? ${pkgs.stdenv.hostPlatform.system} 
                               && flake.legacyPackages.${pkgs.stdenv.hostPlatform.system} ? nixosConfigurations 
                               && flake.legacyPackages.${pkgs.stdenv.hostPlatform.system}.nixosConfigurations ? vane 
                            then flake.legacyPackages.${pkgs.stdenv.hostPlatform.system}.nixosConfigurations.vane.options
                            else
                            {};
                        in
                          options
                      '';
                    };
                  };
                };
              };
            };
          };
        };
      };
    };

  };
}
