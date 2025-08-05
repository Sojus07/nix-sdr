{ config, pkgs, ... }:
let
  gnss-sdr     = import ./gnss-sdr.nix     { inherit pkgs; };
in
{
  services = {
    sdrPlayApi.enable = true;      
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
    sdrtrunk

    gnss-sdr
  ];
}
