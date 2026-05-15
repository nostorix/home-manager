{ pkgs, ... }:
{

  home.packages = with pkgs; [
    substratum.wake-home
    app2unit
    seahorse
    ripgrep
    trash-cli
    wl-clipboard
    vesktop
  ];

}
