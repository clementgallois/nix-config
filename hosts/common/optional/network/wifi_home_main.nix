{ config, ... }:
{
  sops.secrets."wifi_home_main_ssid" = {
    sopsFile = ./wifi_home_main_secrets.yaml;
    key = "ssid";
  };

  sops.secrets."wifi_home_main_psk" = {
    sopsFile = ./wifi_home_main_secrets.yaml;
    key = "psk";
  };

  sops.templates."wifi_home_main.env".content = ''
    WIFI_HOME_MAIN_SSID=${config.sops.placeholder."wifi_home_main_ssid"}
    WIFI_HOME_MAIN_PSK=${config.sops.placeholder."wifi_home_main_psk"}
  '';
  networking.networkmanager = {

    # generated in /run/NetworkManager/system-connections/
    ensureProfiles = {

      environmentFiles = [
        config.sops.templates."wifi_home_main.env".path
      ];

      profiles = {
        "home_main" = {
          connection = {
            #reuse ssid ??
            id = "home_main";
            type = "wifi";
            autoconnect = true;
            autoconnect-priority = 1;
          };
          wifi = {
            mode = "infrastructure";
            ssid = "$WIFI_HOME_MAIN_SSID";
          };
          wifi-security = {
            key-mgmt = "sae";
            psk = "$WIFI_HOME_MAIN_PSK";
          };
          ipv4 = {
            method = "auto";
          };
          ipv6 = {
            method = "auto";
            dns-search = "";
            addr-gen-mode = "stable-privacy";
          };
        };
      };
    };
  };
}
