return {
    'mbbill/undotree',

    config = function()
	vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = '[U]ndotree' })
	vim.g.undotree_SetFocusWhenToggle = 1
    end
}
