{ pkgs, ... }:
{
  config = {
    # suspend fix
    systemd.services.t2suspendfix = {
      enable = true;
      description = "modules to be unloaded and reloaded for suspend";
      unitConfig = {
        StopWhenUnneeded = "yes";
      };
      before = [ "sleep.target" ];
      serviceConfig = {
        User = "root";
        Type = "oneshot";
        RemainAfterExit = "yes";
        ExecStart = [
          "-${pkgs.kmod}/bin/modprobe -r brcmfmac_wcc"
          "-${pkgs.kmod}/bin/modprobe -r brcmfmac"
          "-${pkgs.kmod}/bin/rmmod -f apple-bce"
        ];
        ExecStop = [
          "-${pkgs.kmod}/bin/modprobe apple-bce"
          "-${pkgs.kmod}/bin/modprobe brcmfmac"
          "-${pkgs.kmod}/bin/modprobe brcmfmac_wcc"
        ];
      };
      wantedBy = [ "sleep.target" ];
    };

    systemd.sleep.extraConfig = ''
      # HibernateDelaySec=1h # no swap
      SuspendState=mem # suspend2idle is buggy :(
    '';
  };
}
