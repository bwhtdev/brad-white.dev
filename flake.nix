{
  description = "Brad White's Dev Portfolio Site";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      packages.${system}.default = pkgs.stdenv.mkDerivation {
        name = "brad-white.dev";
        src = self;
        buildInputs = with pkgs; [ static-web-server ];
        nativeBuildInputs = with pkgs; [ makeWrapper ];
        installPhase = ''
          mkdir -p $out/bin
          cp ${self}/serve.sh $out/bin/serve
          chmod +x $out/bin/serve
          wrapProgram $out/bin/serve \
            --prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.nodejs_20 pkgs.static-web-server ]}
        '';
      };

      defaultPackage.${system} = self.packages.${system}.default;
    };
}
