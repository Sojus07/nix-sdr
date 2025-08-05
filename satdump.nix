{ pkgs }: 
pkgs.stdenv.mkDerivation rec {
  pname = "satdump";
  version = "1.2.2";

  src = pkgs.fetchFromGitHub {
    owner = "SatDump";
    repo = "SatDump";
    rev = version;
    sha256 = "sha256-+Sne+NMwnIAs3ff64fBHAIE4/iDExIC64sXtO0LJwI0=";
  };

  nativeBuildInputs = with pkgs; [ cmake pkg-config ];
  buildInputs = with pkgs; [
    fftwFloat libpng libtiff jemalloc volk
    rtl-sdr-librtlsdr hackrf airspy airspyhf
    glfw zenity zstd libad9361 libiio
    curlFull.dev curlFull.out armadillo
    mbedtls nng opencl-headers hdf5
  ];
  
  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
    "-DCMAKE_INSTALL_LIBDIR=lib"
  ];
}
