{
  description = "NixOS SDR";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = { self, nixpkgs }: {
    nixosModules.default = import ./sdr.nix;
  };
}
