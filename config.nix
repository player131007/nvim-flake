{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  appName = "nvim";
  desktopEntry = false;

  initLua = # lua
    ''
      vim.loader.enable() -- enable this asap

      vim.o.exrc = true -- has to be set early
    '';

  plugins = {
    dev.config = {
      pure = lib.fileset.toSource {
        root = ./.;
        fileset = lib.fileset.unions [
          ./plugin
          ./lsp
        ];
      };
      impure = "~/nvim-flake";
    };

    start =
      inputs.mnw.lib.npinsToPlugins pkgs ./start.json
      ++ lib.singleton (
        pkgs.writeTextDir "plugin/+paths.lua" ''
          vim.lsp.config("emmylua_ls", {
            cmd = { "${lib.getExe pkgs.emmylua-ls}" },
          })
          vim.lsp.config("nixd", {
            cmd = { "${lib.getExe pkgs.nixd}" },
          })

          require("conform").formatters = {
            stylua = { command = "${lib.getExe pkgs.stylua}" },
            nixfmt = { command = "${lib.getExe pkgs.nixfmt}" },
          }
        ''
      );

    opt = builtins.attrValues pkgs.vimPlugins.nvim-treesitter.grammarPlugins;
  };
}
