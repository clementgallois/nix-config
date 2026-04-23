{ pkgs, ... }:

{
  # Ensure your system accepts unfree packages (Steam is proprietary)
  nixpkgs.config.allowUnfree = true;

  # Enables 32-bit graphics libraries for older games and Steam interface
  # should be enabled in hardware
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server

    # Add Proton-GE directly into Steam
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  # Enable Feral Interactive's GameMode
  # Automatically optimizes CPU and GPU scheduler when a game is launched
  # copied https://github.com/Misterio77/nix-config/blob/9f0a1dfd3e2767a0449ba398de74508a544f91e3/hosts/common/optional/gamemode.nix#L1
  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        softrealtime = "on";
        inhibit_screensaver = 1;
      };
      gpu = {
        apply_gpu_optimisations = "accept-responsibility";
        gpu_device = 0;
        amd_performance_level = "high";
      };
    };
  };

  # Enable Gamescope (optional but highly recommended for Wayland users)
  # Acts as a micro-compositor to fix resolution and scaling issues in games
  programs.gamescope.enable = true;

  # tool to manage Steam, Heroic, Lutris and other gaming components
  # environment.systemPackages = with pkgs; [
  #   mangohud
  # ];
}
