{ pkgs, ... }:
let
  brcmFirmwareSrc2 = pkgs.fetchFromGitHub {
    owner = "clementgallois";
    repo = "brcm-firmware";
    rev = "e9175f6b33f960d93d422eb55f82b484387eea79";
    hash = "sha256-1h8o9f5ez0gouOY1A5VHOe9XkfGoJrN9761/m/EVXnk=";
  };
  # brcmFirmwareSrc = builtins.fetchGit {
  #   url = "https://github.com/clementgallois/brcm-firmware.git";
  #   ref = "main";
  #   rev = "e9175f6b33f960d93d422eb55f82b484387eea79";
  # };
in
{
  hardware.firmware = [
    (pkgs.stdenvNoCC.mkDerivation {
      name = "brcm-firmware-t2";

      src = brcmFirmwareSrc2;
      # Tell Nix to ignore dangling symlinks pointing to the missing cypress folder
      dontCheckForBrokenSymlinks = true;

      installPhase = ''
        mkdir -p $out/lib/firmware
        # copy firmwares
        cp -r lib/firmware/* $out/lib/firmware/

        # Find and delete all broken symlinks so the zstd compression step does not crash
        find $out/lib/firmware -xtype l -delete
      '';
    })
  ];
}
