return {
    'folke/which-key.nvim',

    config = function ()
	-- document existing key chains
	require('which-key').register {
	    ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
	    ['<leader>f'] = { name = '[F]iles', _ = 'which_key_ignore' },
	    ['<leader>S'] = { name = '[S]ymbols', _ = 'which_key_ignore' },
	    ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
	    ['<leader>d'] = { name = '[D]ebug', _ = 'which_key_ignore' },
	    ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
	    ['\\'] = { name = 'vimtex', _ = 'which_key_ignore' },
	}
    end
}
