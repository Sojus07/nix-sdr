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
      gnss-sdr = pkgs.callPackage ./gnss-sdr.nix  { };
      satdump  = pkgs.callPackage ./satdump.nix   { };
      qcsuper  = pkgs.callPackage ./qcsuper.nix   { };
      gr-gsm   = pkgs.callPackage ./gr-gsm.nix    { };
    };

    nixosModules.default = import ./sdr.nix;
  };
}
