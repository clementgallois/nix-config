# tweak for running vm using nix vms
# eg: nix run .#nixosConfigurations.desktop.config.system.build.vm
{ ... }:
{
  virtualisation.vmVariant = {
    virtualisation.memorySize = 4096;
    virtualisation.cores = 4;

    services.qemuGuest.enable = true;
    services.spice-vdagentd.enable = true;
  };
}
