# https://github.com/soopyc/nixos-t2-flake/blob/7d9e3dee4e3ddf8f97c544e076a4f9d9a883d403/nix/substituter.nix#L1
{ ... }:
let
  substituters = [ "https://cache.soopy.moe" ];
in
{
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];

    # nixos adds cache.nixos.org at the very end so specifying that is not needed.
    # on other systems please use extra-substituters to not overwrite that.
    inherit substituters;
    trusted-substituters = substituters;
    trusted-public-keys = [ "cache.soopy.moe-1:0RZVsQeR+GOh0VQI9rvnHz55nVXkFardDqfm4+afjPo=" ];
  };
}
