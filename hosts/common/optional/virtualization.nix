{ pkgs, ... }:
{
  # Enable Podman virtualization
  virtualisation.podman = {
    enable = true;

    # Create a `docker` alias for podman
    dockerCompat = true;

    # Required for containers under podman-compose to be able to talk to each other
    # defaultNetwork.settings.dns_enabled = true;
  };

  # Useful packages for container management
  # environment.systemPackages = with pkgs; [
  #   podman-compose
  #   podman-tui
  # ];

  # use kata micro vm for containers
  # can fallback to a standard, lightweight container using the default OCI runtime
  # with: podman run --runtime=crun [...]
  environment.systemPackages = with pkgs; [
    kata-runtime
  ];

  virtualisation.containers.containersConf.settings = {
    engine = {
      # Set Kata as the default runtime for all containers
      runtime = "kata";
      runtimes = {
        kata = [
          "${pkgs.kata-runtime}/bin/kata-runtime"
        ];
      };
    };
  };
}
