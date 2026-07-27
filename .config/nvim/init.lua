-- Must happen before plugins and remaps are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.termguicolors = false
vim.wo.number = true
vim.wo.relativenumber = true
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.timeout = false
vim.wo.signcolumn = 'yes'
vim.o.completeopt = 'menuone,noselect,popup'
vim.o.pumheight = 12
vim.o.softtabstop = 4
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.scrolloff = 6
vim.o.wrap = false

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>') -- Turn off search highlight with esc

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', function() vim.diagnostic.open_float() end)
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)


-- Don't get dizzy when jumping
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-f>', '<C-f>zz')
vim.keymap.set('n', '<C-b>', '<C-b>zz')

-- Move text in visual mode with J and K
vim.keymap.set('v', 'J', ':m ">+1<CR>gv=gv')
vim.keymap.set('v', 'K', ':m "<-2<CR>gv=gv')

-- Interacting with system clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>p', '"+p')
vim.keymap.set({ 'n', 'v' }, '<leader>P', '"+P')
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y')
vim.keymap.set({ 'n', 'v' }, '<leader>Y', '"+y$')
vim.keymap.set({ 'n', 'v' }, '<leader>d', '"+d')
vim.keymap.set({ 'n', 'v' }, '<leader>D', '"+D')

-- Make omnicomplete the default completion
vim.keymap.set({ 'i' }, '<C-n>', '<C-x><C-o>')

vim.keymap.set({ 'n', 'v' }, '<leader>n', ':norm ')

vim.keymap.set({ 't' }, '<esc>', '<C-\\><C-n>')

-- [[ PLUGINS ]]
vim.pack.add({
	-- { src = 'https://github.com/RRethy/base16-nvim' },
	{ src = 'https://github.com/stevearc/oil.nvim' },
	{ src = 'https://github.com/mbbill/undotree' },
	{ src = 'https://github.com/tpope/vim-fugitive' },
	{ src = 'https://github.com/lewis6991/gitsigns.nvim' },
	{ src = 'https://github.com/L3MON4D3/LuaSnip' },
	{ src = 'https://github.com/nvim-tree/nvim-web-devicons' },
	{ src = 'https://github.com/nvim-telescope/telescope.nvim' },
	{ src = 'https://github.com/nvim-telescope/telescope-fzf-native.nvim' },
	{ src = 'https://github.com/nvim-lua/plenary.nvim' },
	{ src = 'https://github.com/nvim-treesitter/nvim-treesitter',         branch = 'main' },
	{ src = 'https://github.com/nvim-treesitter/nvim-treesitter-context' },
	{ src = 'https://github.com/lervag/vimtex', ft = 'tex' },
	-- { src = 'https://github.com/mason-org/mason.nvim' },
})

require("lsp")
require("statusline")
require("colours")
require("statuscolumn")

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_set_hl(0, 'Yank', { link = 'Cursor' })
vim.api.nvim_create_autocmd('TextYankPost', {
	group = highlight_group,
	pattern = '*',
	callback = function()
		vim.highlight.on_yank({ higroup = 'Yank' })
	end,
})

local ns = vim.api.nvim_create_namespace("my-plugin")
pcall(function() vim.api.nvim_buf_set_extmark(0, ns, 9, 1, { sign_text = "a", sign_hl_group = "DiagnosticSignHint", }) end)
