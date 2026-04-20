{lib, ...}: {
  i18n = {
    defaultLocale = lib.mkDefault "en_US.UTF-8";
    extraLocales = lib.mkDefault [ "fr_FR.UTF-8/UTF-8" ];
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
  };

  # time.timeZone = "Europe/Luxembourg";
  location = {
    provider = "geoclue2";
  };
  services.geoclue2 = {
    enableStatic = lib.mkDefault true;
    # Paris but it's cool numbers
    staticLatitude = 48.88888;
    staticLongitude = 2.22222;
    staticAltitude = 69;
    staticAccuracy = 1;
  };

  # automatic timezone based on ip
  #services.tzupdate.enable = true;
}
