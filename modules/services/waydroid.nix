{ ... }:
{
  flake.homeModules.waydroid-service =
    { pkgs, ... }:
    {
      systemd.user.services.waydroid-session = {
        Unit = {
          Description = "Waydroid User Session";
          After = [
            "graphical-session.target"
            "waydroid-container.service"
          ];
        };
        Install = {
          WantedBy = [ "graphical-session.target" ];
          Requires = [ "graphical-session.target" ];
        };
        Service = {
          Type = "simple";
          ExecStart = "${pkgs.waydroid-nftables}/bin/waydroid session start";
          ExecStop = "${pkgs.waydroid-nftables}/bin/waydroid session stop";

          # Clean up processes on exit
          KillMode = "mixed";

          # Resource limits: 4GB Max, 3GB cache threshold
          MemoryMax = "4G";
          MemoryHigh = "3G";

          TimeoutStopSec = "30s";
          Restart = "on-failure";
        };
      };
    };
}
