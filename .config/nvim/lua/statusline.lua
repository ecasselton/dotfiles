local function lsp()
	local count = {}
	local levels = {
		errors = "Error",
		warnings = "Warn",
		info = "Info",
		hints = "Hint",
	}

	local lsp_client = ""
	local clients = vim.lsp.get_clients({bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)})
	if (clients[1]) then
		lsp_client = clients[1].name .. " "
	end

	for k, level in pairs(levels) do
		count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
	end

	local errors = "%#DiagnosticSignError#  " .. count["errors"]
	local warnings = "%#DiagnosticSignWarn#  " .. count["warnings"]
	local hints = "%#DiagnosticSignHint#  " .. count["hints"]
	local info = "%#DiagnosticSignInfo#  " .. count["info"]

	if count["errors"] == 0 then errors = "" end
	if count["warnings"] == 0 then warnings = "" end
	if count["hints"] == 0 then hints = "" end
	if count["info"] == 0 then info = "" end

	return table.concat({
		errors,
		warnings,
		hints,
		info,
		"%#StatusLSP# ",
		lsp_client,
		" %#StatusLine#"
	})
end

local git = function()
	local git_info = vim.b[vim.api.nvim_win_get_buf(vim.g.statusline_winid)].gitsigns_status_dict
	if not git_info or git_info.head == "" then
		return ""
	end
	local added = git_info.added and ("%#GitSignsAdd#+" .. git_info.added .. " ") or ""
	local changed = git_info.changed and ("%#GitSignsChange#~" .. git_info.changed .. " ") or ""
	local removed = git_info.removed and ("%#GitSignsDelete#-" .. git_info.removed .. " ") or ""

	if git_info.added == 0 then added = "" end
	if git_info.changed == 0 then changed = "" end
	if git_info.removed == 0 then removed = "" end

	return table.concat {
		"%#StatusGit#  ",
		git_info.head,
		" ",
		added,
		changed,
		removed,
	}
end

function Statusline()
	return table.concat({
		"%#StatusLine# %f%m ",
		git(),
		"%=",
		lsp(),
		" %#StatusLine#%c:%l (%p%%)"
	})
end
vim.o.statusline = "%!v:lua.Statusline()"
