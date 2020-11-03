{ lib, buildGoModule, fetchgit }:

buildGoModule rec {
  pname = "bombadillo";
  version = "2.3.1";

  src = fetchgit {
    url = "https://tildegit.org/sloum/bombadillo.git";
    rev = version;
    sha256 = "0n0gza9qfx1hxigicyvf6wg1ccc2irvh17yhzpw9gx75ls5ybrjn";
  };

  vendorSha256 = "0sjjj9z1dhilhpc8pq4154czrb79z9cm044jvn75kxcjv6v5l2m5";

  meta = with lib; {
    description =
      "Non-web client for the terminal, supporting Gopher, Gemini and more";
    homepage = "https://bombadillo.colorfield.space/";
    license = licenses.gpl3;
    maintainers = with maintainers; [ ehmry ];
  };
}
