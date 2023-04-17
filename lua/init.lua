---------------------------------------
--             Init vars             --
---------------------------------------

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '


---------------------------------------
--          Preinit plugins          --
---------------------------------------

-- Initiate pluggin loader --
-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)


------- FRAGMENTATION AND MORE UNDERSTANDING NEEDED
-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',
  
  -- LSP Configuration & Plugins
  require 'plugins.lspconfig', 

  -- Autocompletion
  require 'plugins.cmp',
  
  -- close {, (, ", ', when opening them
  require 'plugins.auto_pairs',
  
  -- rust Cargo toml crate addons
  require 'plugins.crates',

  -- Useful plugin to show you pending keybinds.
  require 'plugins.which_key',

  -- Adds git releated signs to the gutter, as well as utilities for managing changes
  require 'plugins.gitsigns',

  {
    -- Theme inspired by Atom
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'onedark'
    end,
  },

  -- Set lualine as statusline
  require 'plugins.lualine',

  -- Add indentation guides even on blank lines
  require 'plugins.indent_blankline',

  -- "gc" to comment visual regions/lines
  require 'plugins.comment',

  -- Fuzzy Finder (files, lsp, etc)
  require 'plugins.telescope',

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  require 'plugins.telescope_fzf_native',

  -- Highlight, edit, and navigate code
  require 'plugins.treesitter',

  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  require 'plugins.autoformat',

  -- File tree
  require 'plugins.nvim_tree',

  -- display buffers in the bottom bar
  require 'plugins.bufferline',

  -- Toggle nvim transparency
  require("plugins.transparent")
  -- require 'kickstart.plugins.debug',

  -- NOTE: The import below automatically adds your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  --
  --    An additional note is that if you only copied in the `init.lua`, you can just comment this line
  --    to get rid of the warning telling you that there are not plugins in `lua/custom/plugins/`.

  ---- CHECK AND REMOVE THIS
  -- { import = 'custom.plugins' },
}, {})

-- Some plugins that should not be lazy loaded


---------------------------------------
--             Some vars             -- NEED FIX
---------------------------------------

-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

---------------------------------------
--              Configs              -- (allow pluggins to modify vim vars ?)
---------------------------------------

require("configs.telescope")
require("configs.treesitter")
require("configs.lsp")
require("configs.cmp")
require("configs.lualine")
require("configs.nvim_tree")
require("configs.bufferline")
require("configs.transparent")
require("configs.crates")

---------------------------------------
--              Keymaps              --
---------------------------------------

-- [[ Basic Keymaps ]]
---- NEED FIX

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Simple keymaps to manage buffers
vim.keymap.set('n', '<leader>x', "<cmd> bdelete <CR>", { desc = "Close the current buffer" })
vim.keymap.set('n', '<TAB>', "<cmd> bnext <CR>", { desc = "Switch to the next buffer" })
vim.keymap.set('n', '<S-TAB>', "<cmd> bprevious <CR>", { desc = "Switch to the previous buffer" })

---- telescope keymaps
require("keymaps.telescope")

-- diagnostic keymaps -- USELESS IMO
require("keymaps.diagnostic")

-- nvimtree keymaps
require("keymaps.nvim_tree")
