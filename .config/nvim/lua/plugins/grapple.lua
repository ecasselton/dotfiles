return {
    "cbochs/grapple.nvim",
    opts = {
        scope = "git", -- also try out "git_branch"
    },
    event = { "BufReadPost", "BufNewFile" },
    cmd = "Grapple",
	config = function()
		for i = 97, 97+25 do
			vim.keymap.set("n", "<leader>m"..string.char(i), "<cmd>Grapple tag name="..string.char(i).."<cr>") vim.keymap.set("n", "<M-"..string.char(i)..">", "<cmd>Grapple select name="..string.char(i).."<cr>")
		end
	end
}
