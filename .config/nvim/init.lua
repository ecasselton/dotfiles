-- Must happen before plugins and remaps are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.termguicolors = true
vim.wo.number = true
vim.wo.relativenumber = true
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.timeout = false
vim.wo.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.completeopt = 'menuone'
vim.o.softtabstop = 4
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.scrolloff = 6
vim.o.wrap = false
vim.o.linebreak = true
vim.o.winborder = 'rounded'
-- vim.o.colorcolumn = '80'

-- Turn off search highlight with esc
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', function () vim.diagnostic.jump({count=1, float=true}) end, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', function () vim.diagnostic.jump({count=-1, float=true}) end, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>q', function () vim.diagnostic.open_float({ border = 'rounded' }) end, { desc = 'Open floating diagnostic message' })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Don't get dizzy when jumping
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-f>", "<C-f>zz")
vim.keymap.set("n", "<C-b>", "<C-b>zz")

-- Move text in visual mode with J and K
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<leader>kms", "<cmd>CellularAutomaton make_it_rain<CR>")

-- Interacting with system clipboard
vim.keymap.set({"n", "v"}, "<leader>p", '"+p')
vim.keymap.set({"n", "v"}, "<leader>P", '"+P')
vim.keymap.set({"n", "v"}, "<leader>y", '"+y')
vim.keymap.set({"n", "v"}, "<leader>Y", '"+y$')
-- vim.loader.enable()

-- Use extended regex for substitute commands
-- vim.cmd("cabbrev s s/\\v")
-- vim.cmd("cabbrev %s %s/\\v<BS>")

-- Keybinds for marks
-- for v = 65, 65+25  do
-- 	vim.keymap.set("n", "<M-"..string.char(v+32)..">", '`'..string.char(v))
-- end

-- [[ Bootstrap lazy.nvim ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end

vim.opt.rtp:prepend(lazypath)

-- [[ Configure plugins ]]
require('lazy').setup(
	{

		{ import = 'plugins' }
	},
	{
		ui = { border = "rounded" }
	}
)


-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_set_hl(0, "Yank", { link = "Cursor" })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank( { higroup="Yank" } )
    end,
    group = highlight_group,
    pattern = '*',
})

-- [[ Force write if inside OneDrive ]]
-- This forces neovim to ignore the modified time, caused by onedrive-abraunegg
vim.api.nvim_create_autocmd('BufWriteCmd', {
	callback = function()
		local isOneDriveFile = string.find(vim.api.nvim_buf_get_name(0), "OneDrive")
		if isOneDriveFile then
			vim.cmd("write!")
		else
			vim.cmd("write")
		end
	end
})
