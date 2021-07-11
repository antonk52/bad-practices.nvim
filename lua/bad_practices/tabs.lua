local utils = require('bad_practices/util')
local M = {}

function M.check()
    local current_tabs = table.maxn(vim.api.nvim_list_tabpages())
    local most_tabs = require('bad_practices').get_user_options().most_tabs

    if current_tabs > most_tabs then
        utils.print_warn('Too many tabs, use buffers instead. see :h buffers')
    end
end

local has_event = false
function M.setup()
    if has_event == false then
        has_event = true
        vim.cmd("autocmd CursorHold * lua require('bad_practices.tabs').check()")
    end
end

return M
