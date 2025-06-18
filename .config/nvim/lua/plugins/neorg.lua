return {
	"nvim-neorg/neorg",

	lazy = true,
	ft = "norg",
	event = "VeryLazy",
	config = function()
		require("neorg").setup({
			load = {
				["core.defaults"] = {},
				["core.concealer"] = {
					config = {
						icon_preset = "varied",
						icons = {
							code_block = {
								content_only = false,
								width = "content",
								highlight = "CursorLine",
							},
							todo = {
								recurring = { icon = '' },
								urgent = { icon = '' },
							}
						}
					},
				},
				["core.qol.todo_items"] = {
					config = {
						order = {
							{ "undone", " " },
							{ "done",   "x" },
						}
					}
				},
				["core.export"] = {},
			}
		})
		vim.keymap.set("n", "<C-t>", "<Plug>(neorg.qol.todo-items.todo.task-cycle)")
		-- More ergonomic keymaps for my symbol layer
		vim.keymap.set("n", "<-", "<Plug>(neorg.promo.demote)")
		vim.keymap.set("n", ">-", "<Plug>(neorg.promo.promote)")
	end
}
