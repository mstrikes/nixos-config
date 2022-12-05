{ config, lib, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      {
        type = "lua";
        plugin = nvim-treesitter.withAllGrammars;
        config = builtins.readFile ./treesitter.lua;
      }
      nvim-treesitter-context
      nvim-treesitter-refactor
      nvim-treesitter-textobjects
      nvim-lspconfig

      {
        type = "lua";
        plugin = nordic-nvim;
        config = ''require('nordic').colorscheme({})'';
      }

      {
        type = "lua";
        plugin = pkgs.emptyFile;
        config = builtins.readFile ./settings.lua;
      }
    ];
  };
}
