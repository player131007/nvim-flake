{ inputs, lib, pkgs, ... }:
{
  appName = "nvim";
  desktopEntry = false;

  initLua = /* lua */ ''
    vim.loader.enable() -- enable this asap

    vim.o.exrc = true -- has to be set early
  '';

  plugins = {
    dev.config = {
      pure = lib.fileset.toSource {
        root = ./.;
        fileset = lib.fileset.unions [ ];
      };
      impure = "~/nvim-flake";
    };

    start = inputs.mnw.lib.npinsToPlugins pkgs ./start.json;

    opt = builtins.attrValues pkgs.vimPlugins.nvim-treesitter.grammarPlugins;
  };
}
