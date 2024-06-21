-- Must happen before plugins and remaps are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.o.termguicolors = true

require('opts')

-- vim.loader.enable()

-- [[ Install `lazy.nvim` plugin manager ]]
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

-- [[ Configure plugins ]]
require('lazy').setup({
    'eandrju/cellular-automaton.nvim',
    'theprimeagen/vim-be-good',

    -- Git related plugins
    'tpope/vim-fugitive',
    -- 'tpope/vim-rhubarb',
    -- { 'ecasselton/polarbare.nvim', opts = {} },

    -- Detect tabstop and shiftwidth automatically
    'tpope/vim-sleuth',

    { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },

    -- "gc" to comment visual regions/lines
    { 'numToStr/Comment.nvim', opts = {} },

    { import = 'plugins' }
}, {})


-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_set_hl(0, "Yank", { link = "Search" })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank( { higroup="Yank" } )
    end,
    group = highlight_group,
    pattern = '*',
})


-- [[ Manage dotfiles bare git repo ]]
CheckIfDotfile = function(git_dir, work_tree)
	local buf_name = vim.api.nvim_buf_get_name(0)
	if buf_name == "" then
		return false
	end
	local command = "/usr/bin/git --git-dir="..git_dir.." --work-tree="..work_tree.." ls-files --error-unmatch "..buf_name

	vim.fn.system(command)
	local exit_code = vim.v.shell_error

	if exit_code == 0 then
		return true
	else
		return false
	end
end

local git_dir = vim.fn.expand("~/.dotfiles")
local work_tree = vim.fn.expand("~")

if CheckIfDotfile(git_dir, work_tree) then
    vim.env.GIT_DIR = git_dir
    vim.env.GIT_WORK_TREE = work_tree
end

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=4 sts=4 sw=4 et
