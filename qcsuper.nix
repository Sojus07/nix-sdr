{ pkgs }:

pkgs.python3Packages.buildPythonApplication rec {
  pname = "qcsuper";
  version = "2.0.1";

  src = pkgs.fetchFromGitHub {
    owner = "P1sec";
    repo = "QCSuper";
    rev = "${version}";
    sha256 = "sha256-m75yoFO+NR5WyckmJfPtjXAajbDHB2PFBc7sznVQnw8=";
  };

  pyproject = true;
  build-system = [ pkgs.python3Packages.setuptools ];

  propagatedBuildInputs = with pkgs.python3Packages; [
    pyserial
    pyusb
    crcmod
  ];
}
