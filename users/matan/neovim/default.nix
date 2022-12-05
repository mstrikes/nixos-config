{ config, lib, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      {
        type = "lua";
        plugin = pkgs.emptyFile;
        config = builtins.readFile ./settings.lua;
      }
      {
        type = "lua";
        plugin = nordic-nvim;
        config = ''require('nordic').colorscheme({})'';
      }
      {
        type = "lua";
        plugin = nvim-treesitter.withAllGrammars;
        config = builtins.readFile ./treesitter.lua;
      }
      nvim-treesitter-context
      nvim-treesitter-refactor
      nvim-treesitter-textobjects

      {
        type = "lua";
        plugin = nvim-lspconfig;
        config = builtins.readFile ./lsp.lua;
      }
      nvim-cmp
      cmp-nvim-lsp
      luasnip
      cmp-luasnip
    ];

    exraPackages = with pkgs; [
      rnix-lsp
    ];
  };
}
