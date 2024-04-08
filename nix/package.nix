{ wrapNeovimUnstable
, neovim-unwrapped
, neovimUtils
, lib
, vimPlugins
, vimUtils
, callPackage

, clang-tools
, lua-language-server
, nil
, llvmPackages

, runtimepath ? []
# rose pine colorscheme
, colorscheme ? {
    base00 = "191724";
    base01 = "1f1d2e";
    base02 = "26233a";
    base03 = "6e6a86";
    base04 = "908caa";
    base05 = "e0def4";
    base06 = "e0def4";
    base07 = "524f67";
    base08 = "eb6f92";
    base09 = "f6c177";
    base0A = "ebbcba";
    base0B = "31748f";
    base0C = "9ccfd8";
    base0D = "c4a7e7";
    base0E = "f6c177";
    base0F = "524f67";
  }
}:
let
    neovimConfig = (neovimUtils.makeNeovimConfig {
        withPython3 = false;
        withRuby = false;

        plugins = (with vimPlugins; [
            nvim-treesitter.withAllGrammars
        ]) ++ lib.pipe (callPackage ./sources.nix {}) [
            (lib.flip builtins.removeAttrs [ "override" "overrideDerivation" ])
            (lib.mapAttrsToList (name: src: vimUtils.buildVimPlugin { inherit name src; }))
        ];
    }) // {
        neovimRcContent = null;
        luaRcContent =
        let
            makeLuaList = list: "{ ${lib.concatStringsSep "," list} }";
        in ''
            vim.opt.runtimepath:prepend ${makeLuaList (map (str: "'${str}'") runtimepath)}
            require('base16-colorscheme').setup ${makeLuaList (lib.mapAttrsToList (k: v: "${k}='#${v}'") colorscheme)}
            require "init"
        '';
    };

    neovim = wrapNeovimUnstable neovim-unwrapped neovimConfig;
in neovim.overrideAttrs (prev: {
    generatedWrapperArgs = prev.generatedWrapperArgs or [] ++ [
        "--prefix"
        "PATH"
        ":"
        (lib.makeBinPath [
            clang-tools
            lua-language-server
            nil
            llvmPackages.libstdcxxClang

            # llvm-symbolizer
            llvmPackages.libllvm
        ])
    ];
})

