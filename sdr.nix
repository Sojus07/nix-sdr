{ config, pkgs, ... }:
let
  gnss-sdr   = import ./gnss-sdr.nix   { inherit pkgs; };
  satdump    = import ./satdump.nix    { inherit pkgs; }; 
  qcsuper    = import ./qcsuper.nix    { inherit pkgs; };
  gr-gsm     = import ./gr-gsm.nix     { inherit pkgs; };
  imsi-catcher = import ./imsi-catcher.nix { inherit pkgs; };
in
{
  nixpkgs.config.allowUnfree = true;
  services = {
    sdrplayApi.enable = true;      
  };
  hardware = {
    hackrf.enable = true;
    rtl-sdr.enable = true;
  };
  
  environment.systemPackages = with pkgs; [
    gnuradio
    gnuradioPackages.osmosdr
    multimon-ng
    sdrpp
    qsstv
    wsjtx
    osmo-bts
    osmo-bsc
    kalibrate-hackrf
    srsran
    hackrf
    rtl-sdr
    rtl_433
    soapyhackrf
    wireshark

    gnss-sdr
    satdump
    qcsuper
    gr-gsm
    imsi-catcher
  ];
}
