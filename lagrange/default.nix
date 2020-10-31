{ stdenv, fetchurl, cmake, pkgconfig, SDL2, openssl, pcre, zlib, libunistring }:

stdenv.mkDerivation rec {
  pname = "lagrange";
  version = "0.4.0";

  src = fetchurl {
    url =
      "https://git.skyjake.fi/skyjake/lagrange/releases/download/v${version}/lagrange-${version}.tar.gz";
    hash = "sha256-Dt3KZicgeG93sRxF3DeHXGG5Lmrxhv/3+tQDRE/28mE=";
  };

  nativeBuildInputs = [ cmake pkgconfig ];

  buildInputs = [ SDL2 openssl pcre zlib libunistring ];

  hardeningDisable = [ "format" ];

  meta = with stdenv.lib; {
    description = "Desktop GUI client for browsing Geminispace";
    homepage = "https://git.skyjake.fi/skyjake/lagrange";
    license = licenses.bsd2;
  };

}
