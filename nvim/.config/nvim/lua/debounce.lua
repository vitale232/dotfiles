-- based on https://github.com/hrsh7th/nvim-cmp/issues/598#issuecomment-984930668

local M = {}

local cmp = require("cmp")
local timer = vim.loop.new_timer()

local DEBOUNCE_DELAY = 300

function M.debounce()
	timer:stop()
	timer:start(
		DEBOUNCE_DELAY,
		0,
		vim.schedule_wrap(function()
			cmp.complete({ reason = cmp.ContextReason.Auto })
		end)
	)
end

return M
