return {
	"dhruvasagar/vim-table-mode",
	ft = { "norg", "markdown" },
	config = function()
		vim.keymap.set("i", "__", '<cmd>TableModeToggle<cr>')
	end
}
