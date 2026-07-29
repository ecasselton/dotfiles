-- Must happen before plugins and remaps are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

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

vim.opt.guicursor:remove({
  "t:block-blinkon500-blinkoff500-TermCursor",
})

-- [[ PLUGINS ]]
vim.pack.add({
	{ src = 'https://github.com/stevearc/oil.nvim' },
	{ src = 'https://github.com/mbbill/undotree' },
	{ src = 'https://github.com/tpope/vim-fugitive' },
	{ src = 'https://github.com/lewis6991/gitsigns.nvim' },
	{ src = 'https://github.com/L3MON4D3/LuaSnip' },
	{ src = 'https://github.com/ibhagwan/fzf-lua' },
	{ src = 'https://github.com/nvim-treesitter/nvim-treesitter', branch = 'main' },
	{ src = 'https://github.com/lervag/vimtex', ft = 'tex' },
	-- { src = 'https://github.com/mason-org/mason.nvim' },
})

require("colours")
require("lsp")
require("treesitter")
require("statusline")
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
