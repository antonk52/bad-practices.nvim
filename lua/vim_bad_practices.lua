local CONST = {
    most_splits = 3,
    most_tabs = 3,
}

-- load user options
for k,v in pairs(CONST) do
    if vim.api.nvim_eval('exists("g:bad_practices_' .. k .. '")') == 1 then
        CONST[k] = vim.api.nvim_get_var('bad_practices_' .. k)
    end
end

local function print_vim_warn(msg)
    vim.api.nvim_command("echohl WarningMsg | echo '" .. msg .. "' | echohl None")
end

local function check_splits()
    local current_splits = tonumber(vim.api.nvim_command_output('echo len(tabpagebuflist())'))

    if current_splits > CONST.most_splits then
        print_vim_warn('Too many splits, use buffers instead. see :h buffers')
    end
end

local function check_tabs()
    local current_tabs = tonumber(vim.api.nvim_command_output('echo tabpagenr("$")'))

    if current_tabs > CONST.most_tabs then
        print_vim_warn('Too many tabs, use buffers instead. see :h buffers')
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

return {
    check_static = check_static,
}
