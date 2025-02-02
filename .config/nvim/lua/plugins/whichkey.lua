return {
    'folke/which-key.nvim',

    dependencies = {
	{ 'echasnovski/mini.nvim', version = false },
	'nvim-tree/nvim-web-devicons',
    },

    config = function ()
	-- document existing key chains
	require('which-key').add {
	    -- { "<leader>c", },
	    { "<leader>d", group = "[D]ebug", icon = "" },
	    { "<leader>f", group = "[F]ind", icon = ""  },
	    { "<leader>g", group = "[G]it", icon = "" },
	    -- { "<leader>w", group = "[W]orkspace" },
	    { "<leader>l", group = "[L]SP" },
	    { "<leader>u", icon = "" },
	    { "\\", group = "vimtex" },
	}

    end
}
