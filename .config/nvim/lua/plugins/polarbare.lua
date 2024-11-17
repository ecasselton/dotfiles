return {
	dir = '~/repos/polarbare.nvim',
	dev = { true },
	config = function()
		require('polarbare').setup()
	end
}
