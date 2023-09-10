{ python3Packages, stdenv, fetchFromGitHub, cmake }:
with python3Packages;
stdenv.mkDerivation rec {
  name = "mavlink";

  src = fetchFromGitHub {
    owner = "mavlink";
    repo = "mavlink";
    rev = "18955a04c7c7467e00ea42b704addb4a9c12b53a";
    fetchSubmodules = false;
    sha256 = "sha256-5XfBtfRwUHW4Hb/cLbXlsVQH9tOawMTCxWiCS4M1gTs=";
  };

  patches = [
    ./0001-skip-pip-pymavlink.patch
  ];

  cmakeFlags = [
    "-DMAVLINK_DIALECT=common"
    "-DMAVLINK_VERSION=2.0"
  ];

  nativeBuildInputs = [ cmake pymavlink ];
}
