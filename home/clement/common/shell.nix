{ pkgs, ... }:
{
  # --- Kitty Configuration ---
  # High-performance, GPU-accelerated terminal
  programs.kitty = {
    enable = true;
    font = pkgs.nerd-fonts.fira-code;
    settings = {
      # Scrollback and performance
      scrollback_lines = 10000;
      enable_audio_bell = false;
      # UI transparency (looks good with GNOME)
      background_opacity = "0.95";
      window_padding_width = 10;
      # Disable checking for updates (handled by Nix)
      update_check_interval = 0;
    };
    # Default theme (uncomment or change if you have kitty-themes)
    # theme = "Catppuccin-Mocha";
  };

  # --- Foot Configuration ---
  # Lightweight, Wayland-native terminal
  programs.foot = {
    enable = true;
    # Enable server mode for instant window creation
    server.enable = true;
    settings = {
      main = {
        font = "FiraCode Nerd Font:size=11";
        pad = "12x12";
        dpi-aware = "yes";
      };
      # colors = {
      # Default dark palette (Catppuccin-like)
      # background = "1e1e2e";
      # foreground = "cdd6f4";
      # };
    };
  };

  # --- Ghostty Configuration ---
  # Modern terminal with GPU acceleration (Zig)
  # Note: Since home-manager modules for Ghostty are very new,
  # we use the direct configuration file approach for compatibility.

  programs.ghostty = {
    enable = true;
    settings = {
      font-family = "FiraCode Nerd Font";
      font-size = 11;

      # Padding for a cleaner look
      window-padding-x = 10;
      window-padding-y = 10;

      window-decoration = true;

    };
  };
}
