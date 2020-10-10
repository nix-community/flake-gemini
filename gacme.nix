{ stdenv, fetchgit, plan9port }:

stdenv.mkDerivation {
  name = "gacme-unstable-2020-07-07";
  src = fetchgit {
    url = "https://git.sr.ht/~parker/gacme";
    sha256 = "1iwyg467irp45zrjmhizi4xljq1b0pgdzxs3wbh6bsgaq5d7c6ss";
  };

  PLAN9 = "${plan9port}/plan9";

  buildPhase = ''
    substituteInPlace gacme \
      --replace "!/usr/bin/env rc" "!$PLAN9/bin/rc" \
      --replace /usr/local $out
  '';

  installPhase = ''
    install -Dm755 {,$out/bin/}gacme
    install -D {,$out/lib/}parseGeminiResponse.awk
    install -D {,$out/lib/}getMeta.awk
  '';

}
