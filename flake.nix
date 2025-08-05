{
  description = "NixOS SDR";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = { self, nixpkgs }: let 
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    packages.${system} = {
      gnss-sdr = pkgs.callPackage ./gnss-sdr.nix { };
      satdump = pkgs.callPackage ./satdump.nix { };
    };

    nixosModules.default = import ./sdr.nix;
  };
}
