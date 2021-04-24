{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "html2gmi";
  version = "unstable-2020-11-15";

  src = fetchFromGitHub {
    owner = "LukeEmmet";
    repo = pname;
    rev = "928eec33eeabae7443d5a6abcbfbfbc9f95ebe8a";
    hash = "sha256-i0cK4pvu2Spo4KJD0NRcV0Z4EpBRMN6DlThbcoL2EG0=";
  };

  vendorSha256 = "sha256-dHJQaYg4rQ1FZm5pyPzOVvOuAdUiA+SGvYGGX9R9zAQ=";

  meta = with lib;
    src.meta // {
      description =
        "A command line application to convert HTML to GMI (Gemini text/gemini) ";
      license = licenses.mit;
      maintainers = with maintainers; [ ehmry ];
    };
}
