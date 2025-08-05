{ pkgs }:
pkgs.stdenv.mkDerivation rec {
  pname = "gnss-sdr";
  version = "0.0.20";

  src = pkgs.fetchFromGitHub {
    owner = "gnss-sdr";
    repo = "gnss-sdr";
    rev = "v${version}";
    sha256 = "sha256-kQv8I4dcWeRuAfYtD5EAAMwvfnOTi+QWDogUZb4M/qQ=";
  };

  nativeBuildInputs = with pkgs; [ cmake pkg-config python3 git ];
  buildInputs = with pkgs; [
    volk boost fftw protobuf pugixml
    gnuradio gnuradioPackages.osmosdr
    armadillo glog gflags spdlog
    python3Packages.mako blas lapack
    gnutls openssl zlib hdf5 matio
    libiio gtest orc
  ];

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
    "-DCMAKE_INSTALL_LIBDIR=lib"
    "-DENABLE_OSMOSDR=ON"
    "-DENABLE_VOLK_GNSSSDR=ON"
    "-DENABLE_UNIT_TESTING=OFF"
    "-DENABLE_OWN_GLOG=OFF"
    "-DENABLE_OWN_ARMADILLO=OFF"
  ];
  enableParallelBuilding = true;

  buildPhase = ''
    runHook preBuild
    make volk_gnsssdr_module -j$NIX_BUILD_CORES
    make volk_gnsssdr_module_install -j$NIX_BUILD_CORES || true
    make -j$NIX_BUILD_CORES
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    make install
    runHook postInstall
  '';
}

