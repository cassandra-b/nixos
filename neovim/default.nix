{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    extraPackages = [ pkgs.nixfmt ];
    plugins = [
      {
        plugin = pkgs.vimPlugins.neoformat;
        type = "lua";
        config = ''
          vim.api.nvim_create_autocmd("BufWritePre", {
            command = "Neoformat",
            group = vim.api.nvim_create_augroup("fmt", {}),
          })

          vim.api.nvim_create_autocmd("TextYankPost", {
            callback = vim.highlight.on_yank,
            group = vim.api.nvim_create_augroup("YankHighlight", {}),
          })
        '';
      }
      {
        plugin = pkgs.vimPlugins.nvim-tree-lua;
        type = "lua";
        config = ''
          require("nvim-tree").setup({
            remove_keymaps = {"<Tab>"}
          })
          vim.keymap.set('n', '<tab>', '<cmd>NvimTreeToggle<cr>', { noremap = true })
        '';
      }
      {
        plugin = pkgs.vimPlugins.telescope-nvim;
        type = "lua";
        config = ''
          require('telescope').setup({
            defaults = {
              mappings = {
                i = { ["<esc>"] = require("telescope.actions").close },
              },
            },
          })

          local telescope_builtin = require('telescope.builtin')
          vim.keymap.set('n', '<c-p>', telescope_builtin.find_files, { noremap=true })
          vim.keymap.set('n', '<m-p>', telescope_builtin.buffers, { noremap=true })
          vim.keymap.set('n', '<m-;>', telescope_builtin.live_grep, { noremap=true })
        '';
      }
      {
        plugin = pkgs.vimPlugins.vim-airline;
        type = "lua";
        config = "vim.g.airline_powerline_fonts = 0";
      }
      {
        plugin = pkgs.vimPlugins.vim-airline-themes;
        type = "lua";
        config = "vim.g.airline_theme = 'dark_minimal'";
      }
      pkgs.vimPlugins.vim-colorschemes
      pkgs.vimPlugins.vim-nix
    ];
  };
}
