{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    m3shapes-src = {
      url = "github:soramanew/m3shapes/bdc327b29f95394a732baf3c9b19658ba23755b6";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      m3shapes-src,
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      m3shapes = pkgs.stdenv.mkDerivation {
        name = "m3shapes";
        src = m3shapes-src;
        nativeBuildInputs = with pkgs; [
          cmake
          ninja
          pkgs.autoPatchelfHook
          qt6.wrapQtAppsHook
        ];
        buildInputs = with pkgs; [
          qt6.qtbase
          qt6.qtdeclarative
        ];
      };

      cshell = pkgs.stdenv.mkDerivation {
        pname = "cshell";
        version = "0.1";
        nativeBuildInputs = [
          pkgs.makeWrapper
          m3shapes
        ];
        src = ./.;
        installPhase = ''
          mkdir -p $out/share/cshell
          cp -r . $out/share/cshell
          makeWrapper ${pkgs.quickshell}/bin/qs $out/bin/cshell \
          --set QML_IMPORT_PATH "${m3shapes}/usr/lib/qt6/qml:$QML_IMPORT_PATH" \
          --add-flags "-p $out/share/cshell"
        '';
      };

    in
    {
      packages.${system}.default = cshell;
      apps.${system}.default = {
        type = "app";
        program = "${cshell}/bin/cshell";
      };
    };
}
