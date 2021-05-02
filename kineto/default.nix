{ lib, buildGoModule, fetchgit }:

buildGoModule rec {
  pname = "kineto";
  version = "2021-02-24";

  src = fetchgit {
    url = "https://git.sr.ht/~sircmpwn/kineto";
    rev = "edd4fe31f16f9eb9565d2b6a329738ceedea8de9";
    sha256 = "sha256-qRBD9b4Vtb23pzsnSwbNly/EUtptCdmM+gq2HMt3jbY=";
  };

  vendorSha256 = "sha256-+CLJJ4najojIE/0gMlhZxb1P7owdY9+cTnRk+UmHogk=";

  meta = with lib; {
    description =
      "HTTP to Gemini proxy designed to provide service for a single domain";
    license = licenses.gpl3;
    maintainers = with maintainers; [ ehmry ];
  };
}
