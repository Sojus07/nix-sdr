# NIX-SDR
its basically just a set with some SDR programs which i want to have on NixOS.

to use it:
add `nix-sdr.url = "github:Sojus07/nix-sdr"` in `inputs`
add `nix-sdr.nixosModules.default` in your `outputs`


currently are following programs provided:
gnss-sdr
satdump
qcsuper
gr-gsm

and other in env.systemPackages

