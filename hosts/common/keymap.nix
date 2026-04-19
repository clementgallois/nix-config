# remap tab to esc + long press = ctrl
{
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
        settings = {
          main = {
            # Tap for escape, hold for control
            capslock = "overload(control, esc)";
          };
        };
      };
    };
  };
}
