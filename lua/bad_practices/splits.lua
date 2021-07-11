local utils = require('bad_practices/util')
local M = {}

function M.check()
    local current_splits = table.maxn(vim.fn.tabpagebuflist())
    local most_splits = require('bad_practices').get_user_options().most_splits

    if current_splits > most_splits then
        utils.print_warn('Too many splits, use buffers instead. See :h buffers')
    end
end

local has_event = false
function M.setup()
    if has_event == false then
        has_event = true
        vim.cmd("autocmd CursorHold * lua require('bad_practices/splits').check()")
    end
end

return M
