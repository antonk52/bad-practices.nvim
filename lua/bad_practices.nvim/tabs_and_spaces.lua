local utils = require('bad_practices.nvim/util')
local CONST = {
    most_splits = 3,
    most_tabs = 3,
}

-- load user options
for k,_ in pairs(CONST) do
    if vim.fn.exists("g:bad_practices_' .. k .. '") == 1 then
        CONST[k] = vim.api.nvim_get_var('bad_practices_' .. k)
    end
end

local function check_splits()
    local current_splits = vim.fn.len(vim.fn.tabpagebuflist())

    if current_splits > CONST.most_splits then
        utils.print_warn('Too many splits, use buffers instead. See :h buffers')
    end
end

local function check_tabs()
    local current_tabs = tonumber(vim.fn.tabpagenr("$"))

    if current_tabs > CONST.most_tabs then
        utils.print_warn('Too many tabs, use buffers instead. see :h buffers')
    end
end

local function check_static()
    if CONST.most_tabs > -1 then
        check_tabs()
    end

    if CONST.most_splits > -1 then
        check_splits()
    end
end

local has_tabs_and_spaces_hold_event = false
local function setup()
    if has_tabs_and_spaces_hold_event == false then
        has_tabs_and_spaces_hold_event = true
        vim.api.nvim_command("autocmd! CursorHold * lua require('bad_practices.nvim/tabs_and_spaces').check_static()")
    end
end

return {
    check_static = check_static,
    setup = setup,
}
