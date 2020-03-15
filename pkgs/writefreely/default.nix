{ stdenv, lib, fetchFromGitHub, buildGoModule, go-bindata }:

buildGoModule rec {
  name = "writefreely-${version}";
  version = "0.11.2";

  src = fetchFromGitHub {
    owner = "writeas";
    repo = "writefreely";
    rev = "v${version}";
    sha256 = "1h6mcsb74ybp4dksylh2avyvgcrc232ny9l1075pmslhqr85kbvv";
  };

  buildInputs = [ go-bindata ];

  modSha256 = "140rh8hfz133flng72j4p9zsmvv05i0330ngsz4b90p2kaavfqqz";
  preBuild = ''
    go-bindata -pkg writefreely -ignore=\\.gitignore -tags="!wflib" schema.sql sqlite.sql
    '';
  buildFlagsArray = [ "-tags='sqlite'" ];

  meta = with lib; {
    description = "A simple, federated blogging platform";
    homepage = https://writefreely.org;
    license = licenses.agpl3;
    maintainers = with maintainers; [ matthiasbeyer ];
    platforms = platforms.linux;
  };
}

