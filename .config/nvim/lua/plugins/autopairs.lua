return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	-- Optional dependency
	dependencies = { 'hrsh7th/nvim-cmp' },
	config = function()
		local npairs   = require('nvim-autopairs')
		local rule = require('nvim-autopairs.rule')
		local cond = require('nvim-autopairs.conds')

		npairs.setup {}

		npairs.add_rule(rule("$", "$", "tex"):with_move(cond.after_text("$")))
		-- Don't autopair brackets after "lr" in latex files,
		-- to allow the snippet engine to close them instead
		npairs.add_rule(rule("lr(", "", {"latex", "tex"}))
		npairs.add_rule(rule("lr[", "", {"latex", "tex"}))
	
		-- If you want to automatically add `(` after selecting a function or method
		local cmp_autopairs = require('nvim-autopairs.completion.cmp')
		local cmp = require('cmp')
		cmp.event:on(
			'confirm_done',
			cmp_autopairs.on_confirm_done()
		)

	end,
}
