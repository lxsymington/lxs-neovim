local nvim_create_augroup = vim.api.nvim_create_augroup
local nvim_create_autocmd = vim.api.nvim_create_autocmd
local M = {}

local augroup_store = {}

-- Autocommand Group Store -------------
M.session_augroups = setmetatable(augroup_store, {
	__call = function(self, group_name, opts)
		local final_opts = opts or { clear = true }
		local group = nvim_create_augroup(group_name, final_opts)
		table.insert(self, group)
		return group
	end,
})

-- Autocommands Index ------------------
local highlight_yank_group = M.session_augroups('HighlightYank')

nvim_create_autocmd('TextYankPost', {
	pattern = '*',
	callback = function()
		vim.highlight.on_yank({
			higroup = 'IncSearch',
			timeout = 150,
		})
	end,
	group = highlight_yank_group,
})

return M
