return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    config = function()
		local markdown = require("render-markdown")
		vim.keymap.set("n", "<leader>mt", markdown.toggle, { desc = "Render [M]arkdown [T]oggle" })

		vim.treesitter.language.register('markdown', 'vimwiki')

		markdown.setup({
			file_types = { 'markdown', 'vimwiki' },

			bullet = {
				icons = { '' },
				-- foregrounds = {}
			},

			heading = {
				position = 'right',
				backgrounds = {
					'transparent',
					'transparent',
					'transparent',
					'transparent',
					'transparent',
					'transparent',
					'transparent',
				},
				foregrounds = {
					'RenderMarkdownH1',
					'RenderMarkdownH2',
					'RenderMarkdownH3',
					'RenderMarkdownH4',
					'RenderMarkdownH5',
					'RenderMarkdownH6',
				},
			}
		})
	end,
}

