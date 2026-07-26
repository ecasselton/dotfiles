local gs = require("gitsigns")

gs.setup({
	worktrees = {
		{
			gitdir = vim.env.HOME .. '/.dotfiles',
			toplevel = vim.env.HOME,
		}
	},
	auto_attach = false,
	signs = {
		add          = { text = '+' },
		change       = { text = '~' },
		delete       = { text = '_' },
		topdelete    = { text = '‾' },
		changedelete = { text = '~' },
		untracked    = { text = '┆' },
	},
	signs_staged = {
		add          = { text = '┃' },
		change       = { text = '┃' },
		delete       = { text = '_' },
		topdelete    = { text = '‾' },
		changedelete = { text = '~' },
		untracked    = { text = '┆' },
	},
})

vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile' }, {
	pattern = '*',
	callback = function(args)
		vim.fn.system("git rev-parse")
		if vim.v.shell_error == 0 then
			require('gitsigns').attach({bufnr = args.buf})
			return
		end

		local buf_name = vim.api.nvim_buf_get_name(args.buf)
		local command = table.concat({
			"/usr/bin/git --git-dir=",
			vim.env.HOME,
			"/.dotfiles --work-tree=",
			vim.env.HOME,
			" ls-files --error-unmatch ",
			buf_name
		})
		vim.fn.system(command)
		if (vim.v.shell_error == 0) then
			vim.env.GIT_DIR = vim.fn.expand("~/.dotfiles")
			vim.env.GIT_WORK_TREE = vim.fn.expand("~")
			require('gitsigns').attach({bufnr = args.buf})
		end
	end,
})

vim.keymap.set('n', '<leader>ga', gs.stage_hunk)
vim.keymap.set('n', '<leader>gA', gs.stage_buffer)
vim.keymap.set('n', '<leader>gu', gs.undo_stage_hunk)
vim.keymap.set('n', '<leader>gp', gs.preview_hunk)
vim.keymap.set('n', '<leader>gr', gs.reset_hunk)
vim.keymap.set('n', '<leader>gR', gs.reset_buffer)
vim.keymap.set('n', '<leader>gb', gs.toggle_current_line_blame)
vim.keymap.set('n', '<leader>gB', function() gs.blame_line({ full = true }) end)
vim.keymap.set('n', '<leader>gd', gs.diffthis)
vim.keymap.set('n', '<leader>gD', function() gs.diffthis('~') end)
