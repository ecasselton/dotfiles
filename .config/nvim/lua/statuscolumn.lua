vim.api.nvim_set_hl(0, "MarksColumn", { ctermfg = 2 })
Marks = {}

vim.api.nvim_create_autocmd({"MarkSet", "TextChanged", "BufReadPost"}, {
	callback = function()
		local bufnr = vim.fn.bufnr("%")
		Marks[bufnr] = {}
		for _, mark in ipairs(vim.fn.getmarklist(bufnr)) do
			local name = mark.mark:sub(2,2)
			if (string.match(name, "%a")) then
				Marks[bufnr][mark.pos[2]] = name
			end
		end
		vim.api.nvim__redraw({ statuscolumn = true })
	end
})

function Statuscolumn()
	return (Marks[vim.fn.bufnr("%")] or {})[vim.v.lnum] or " "
end

vim.opt.statuscolumn = "%C%s%#MarksColumn#%{v:lua.Statuscolumn()} %#Normal#%=%l "
