{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
    mnw.url = "github:Gerg-L/mnw";
  };

  outputs =
    inputs@{
      nixpkgs,
      systems,
      mnw,
      self,
    }:
    let
      eachSystem = nixpkgs.lib.genAttrs (import systems);
    in
    {
      devShells = eachSystem (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShellNoCC {
            packages = [ self.packages.${system}.default.devMode pkgs.npins ];
          };
        }
      );

      packages = eachSystem (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = self.packages.${system}.neovim;
          neovim = mnw.lib.wrap { inherit pkgs inputs; } ./config.nix;
        }
      );
    };
}
