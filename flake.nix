{
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    };

    outputs = { nixpkgs, self, ... }:
    let
        inherit (nixpkgs) lib;
        eachSystem = f: lib.genAttrs
        [
            "aarch64-darwin"
            "aarch64-linux"
            "x86_64-darwin"
            "x86_64-linux"
        ] (system: f nixpkgs.legacyPackages.${system});
    in {
        packages = eachSystem (pkgs: rec {
            default = neovim;
            neovim = pkgs.callPackage ./nix/package.nix {
                extraPlugins = let
                    config = lib.fileset.toSource {
                        root = ./.;
                        fileset = lib.fileset.unions [
                            ./lua
                            ./luasnippets
                            ./plugin
                        ];
                    };
                in [ config ];
            };
        });
    };
}
