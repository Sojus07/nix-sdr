{ pkgs }:
pkgs.python3Packages.buildPythonApplication rec {
  pname = "imsi-catcher";
  version = "master";
  src = pkgs.fetchFromGitHub {
    owner = "Sojus07";
    repo = "IMSI-catcher";
    rev = "master";
    sha256 = "sha256-OTNxrN1YasDQTXAJelb19XBJjZdIq1RZFE05dFCrTM0="; 
  };

  propagatedBuildInputs = with pkgs.python3Packages; [
    numpy scipy scapy
  ];
  
  pyproject = false;
  build-system = [ pkgs.python3Packages.setuptools ];

  installPhase = ''
    runHook preInstall
    
    mkdir -p $out/bin
    cp $src/simple_IMSI-catcher.py $out/bin/IMSI-catcher
    cp -rv $src/mcc-mnc $out/bin/mcc-mnc 
    chmod +x $out/bin/IMSI-catcher

    runHook postInstall
  '';

  pythonImportsCheck = [ "scapy" ];
}
