local oil = require('oil')

oil.setup({
	win_options = {
		signcolumn = "yes:2",
	},
})

vim.keymap.set("n", "<leader>e", oil.open)

vim.api.nvim_set_hl(0, "OilGitAdded", { link = "Added" })
vim.api.nvim_set_hl(0, "OilGitModifiedStaged", { link = "Added" })
vim.api.nvim_set_hl(0, "OilGitModifiedUnstaged", { link = "Changed" })
vim.api.nvim_set_hl(0, "OilGitBranch", { link = "StatusGit" })
vim.api.nvim_set_hl(0, "OilGitRenamed", { link = "Changed" })
vim.api.nvim_set_hl(0, "OilGitDeleted", { link = "Removed" })
vim.api.nvim_set_hl(0, "OilGitCopied", { link = "Changed" })
vim.api.nvim_set_hl(0, "OilGitConflict", { link = "Removed" })
vim.api.nvim_set_hl(0, "OilGitUntracked", { link = "Normal" })
vim.api.nvim_set_hl(0, "OilGitIgnored", { link = "Comment" })
