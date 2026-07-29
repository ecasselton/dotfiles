vim.cmd.colorscheme("retrobox")

vim.api.nvim_set_hl(0, "Normal", { bg = nil })
vim.api.nvim_set_hl(0, "SignColumn", { bg = nil })
vim.api.nvim_set_hl(0, "VertSplit", { bg = nil, fg = "#303030" })

-- vim.api.nvim_set_hl(0, 'NormalFloat', { ctermfg = 8, ctermbg = 0 })
-- vim.api.nvim_set_hl(0, 'Pmenu', { ctermfg = 8, ctermbg = 0 })
-- vim.api.nvim_set_hl(0, 'PmenuSel', { ctermfg = 16, ctermbg = 8, underline = false })
-- vim.api.nvim_set_hl(0, 'PmenuThumb', { ctermbg = 8 })
-- vim.api.nvim_set_hl(0, 'LineNrAbove', { ctermfg = 8 })
-- vim.api.nvim_set_hl(0, 'LineNr', { ctermfg = 8, bold = true })
-- vim.api.nvim_set_hl(0, 'LineNrBelow', { ctermfg = 8 })

-- [[ Signs ]]
vim.api.nvim_set_hl(0, "Added", { fg = "#b8bb26" })
vim.api.nvim_set_hl(0, "Changed", { fg = "#8ec07c" })
vim.api.nvim_set_hl(0, "Deleted", { fg = "#fb5944" })

vim.api.nvim_set_hl(0, "StatusLine", { reverse = false, bg = "#1c1c1c", fg = "#928374"  })
vim.api.nvim_set_hl(0, "StatusLineNC", { reverse = false, bg = "#1c1c1c", fg = "#928374" })
vim.api.nvim_set_hl(0, "StatusGit", { fg = "#fabd2f", bold = true })
vim.api.nvim_set_hl(0, "StatusLSP", { fg = "#b16286", bold = true })

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
