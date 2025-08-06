{ pkgs }:
pkgs.python3Packages.buildPythonApplication rec {
  pname = "gr-gsm";
  version = "porting_to_3.11";

  src = pkgs.fetchFromGitHub {
    owner = "ptrkrysik";
    repo = "gr-gsm";
    rev = version;
    sha256 = "sha256-ILw1n0qdqcqJsuWQ3g1zNP+z2OlJ6sq+AY8LC1lTDJg=";
  };

  nativeBuildInputs = with pkgs; [
    cmake pkg-config swig doxygen
    python3Packages.pybind11 
    python3Packages.pygccxml
    qt5.wrapQtAppsHook
  ];
  

  propagatedBuildInputs = with pkgs; [
    gnuradio gnuradioPackages.osmosdr 
    volk fftw boost
    cppunit libpcap 
    libosmocore 
    log4cpp gmpxx 
    mpir spdlog
    libsForQt5.qtbase
  ] ++ (with pkgs.python3Packages; [
    numpy scipy setuptools pyqt5 matplotlib
  ]);

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
    "-DCMAKE_PREFIX_PATH=${pkgs.gnuradio}/lib/cmake"
  ];

  enableParallelBuilding = true;
  pyproject = false;
  build-system = [ pkgs.python3Packages.setuptools ];

  installPhase = ''
    runHook preInstall

    make install
    mkdir -p $out/bin
    cp -v $src/apps/gr* $out/bin/ || true
    cp -v ${./raw/grgsm_livemon.py} $out/bin/grgsm_livemon 
    chmod +x $out/bin/gr*

    runHook postInstall
  '';
  dontWrapQtApps = false;
  pythonImportsCheck = [ "gnuradio" ];
}
