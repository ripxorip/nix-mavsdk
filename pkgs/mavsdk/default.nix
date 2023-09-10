{ python3, jsoncpp, tinyxml-2, curl, lib, stdenv, fetchFromGitHub, cmake, gcc, mavlink }:

stdenv.mkDerivation rec {
  name = "mavsdk";
  src = fetchFromGitHub {
    owner = "mavlink";
    repo = "MAVSDK";
    rev = "d42e9f2169a07cc664282b719e609103e0adbf27";
    fetchSubmodules = true;
    sha256 = "sha256-vMhvn2TV6po42TnqXmJlShy0BHQG/bPa80rILTD6VdM=";
  };

  cmakeFlags = [
    "-DSUPERBUILD=OFF"
  ];

  buildInputs = [ mavlink tinyxml-2 curl python3 jsoncpp gcc cmake ];
}
