{ pkgs, ... }:
{
  # Power and Thermal.
  services.t2fanrd = {
    enable = true;
    config = {
      # https://github.com/GnomedDev/T2FanRD/blob/master/README.md#nixos-1
      # for speed value, rest is "will see" type of conf"
      fan1 = {
        # min_speed = 1250;
        # max_speed = 6336;

        low_temp = 55; # default
        high_temp = 75; # default
        speed_curve = "logarithmic";
        always_full_speed = false; # default
      };

      fan2 = {
        # min_speed = 1350;
        # max_speed = 6864;

        low_temp = 55; # default
        high_temp = 75; # default
        speed_curve = "logarithmic";
        always_full_speed = false; # default
      };
    };
  };
}
