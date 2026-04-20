{lib, ...}: {
  i18n = {
    defaultLocale = lib.mkDefault "en_US.UTF-8";
    extraLocaleSettings = {
      LC_TIME = lib.mkDefault "fr_FR.UTF-8";
      LC_ADDRESS = lib.mkDefault "fr_FR.UTF-8";
      LC_IDENTIFICATION = lib.mkDefault "fr_FR.UTF-8";
      LC_MEASUREMENT = lib.mkDefault "fr_FR.UTF-8";
      LC_MONETARY = lib.mkDefault "fr_FR.UTF-8";
      LC_NAME = lib.mkDefault "fr_FR.UTF-8";
      LC_NUMERIC = lib.mkDefault "fr_FR.UTF-8";
      LC_PAPER = lib.mkDefault "fr_FR.UTF-8";
      LC_TELEPHONE = lib.mkDefault "fr_FR.UTF-8";
    };
    supportedLocales = lib.mkDefault [
      "en_US.UTF-8/UTF-8"
      "fr_FR.UTF-8/UTF-8"
    ];
  };

  time.timeZone = "Europe/Luxembourg";

  # Need to apparently
  # services.geoclue2.geoProviderUrl = "https://www.googleapis.com/geolocation/v1/geolocate?key=YOUR_KEY"
  # 
  # location.provider = "geoclue2";
  # services.automatic-timezoned.enable = true;
  # systemd.services.automatic-timezoned.serviceConfig.Restart = "always";
}
