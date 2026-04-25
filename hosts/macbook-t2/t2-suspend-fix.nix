{ pkgs, ... }:
{
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

  #do i need this ?
  services.logind.settings = {
    Login = {
      HandleLidSwitch = "suspend";
      HandleLidSwitchExternalPower = "lock";
      # 'Docked' means: more than one display is connected or the system is inserted in a docking station
      HandleLidSwitchDocked = "ignore";

      HandlePowerKey = "suspend";
      HandlePowerKeyLongPress = "poweroff";
    };
  };
  systemd.sleep.settings = {
    Sleep = {
      AllowSuspend = "yes";
      AllowHibernate = "no"; # no swap anyway
      AllowSuspendThenHibernate = "no";
      HibernateDelaySec = "5min";
      SuspendState = "mem"; # suspend2idle is buggy :(
    };
  };
  # systemd.sleep.extraConfig = ''
  #   # HibernateDelaySec=1h # no swap
  #   SuspendState=mem # suspend2idle is buggy :(
  # '';
}
