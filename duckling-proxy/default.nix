{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "duckling-proxy";
  version = "-unstable-2020-09-13";

  src = fetchFromGitHub {
    owner = "LukeEmmet";
    repo = pname;
    rev = "cdb5f327b780d058b2da72026143ad6755afece5";
    hash = "sha256-RAsru9G0kZK5k8BnYt2UK+mdRkh8Zd8jilqh3jyvHOU=";
  };

  vendorSha256 = "0wxk1a5gn9a7q2kgq11a783rl5cziipzhndgp71i365y3p1ssqyf";

  meta = with lib;
    src.meta // {
      description = "Gemini proxy to access the Small Web";
      license = licenses.mit;
      maintainers = with maintainers; [ ehmry ];
    };
}
