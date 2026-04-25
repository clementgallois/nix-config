{
  # https://wiki.t2linux.org/guides/postinstall/#network-manager-recurrent-notification
  services.udev.extraRules = ''
    SUBSYSTEM=="net", ACTION=="add", ATTR{address}=="ac:de:48:00:11:22", NAME="t2_ncm"
  '';

  networking.networkmanager.settings = {
    main = {
      "no-auto-default" = "t2_ncm";
    };
  };
}
