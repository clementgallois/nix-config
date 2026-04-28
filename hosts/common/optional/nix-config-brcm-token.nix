{ config, ... }:
{
  sops.secrets.brcm_github_pat = {
    sopsFile = ./nix-config-brcm-token_secrets.yaml;
  };

  sops.templates."github_brcm_access.conf" = {
    content = "access-tokens = github.com/clementgallois/brcm-firmware=${config.sops.placeholder.brcm_github_pat}";
    mode = "0440";
    # Grant access to the Nix build group so the daemon can read the file
    group = config.nix.settings.build-users-group or "nixbld";
  };
  nix.extraOptions = ''
    !include ${config.sops.templates."github_brcm_access.conf".path}
  '';
}
