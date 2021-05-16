local function print_warn(msg)
    vim.api.nvim_command("echohl WarningMsg | echo '" .. msg .. "' | echohl None")
end

local function setup()
    require('bad_practices/tabs_and_spaces').setup()
    require('bad_practices/hjkl').setup()
end


local function turn_off()
    vim.api.nvim_set_var('bad_practices_enabled', 0)
end

local function turn_on()
    vim.api.nvim_set_var('bad_practices_enabled', 1)
    setup()
end

local function get_global_enabled_var()
    if vim.fn.exists('g:bad_practices_enabled') == 1 then
        local enabled = vim.api.nvim_eval('g:bad_practices_enabled')
        if enabled == 0 or enabled == false then
            return false
        end
    end

    return true
end

return {
    print_warn = print_warn,
    turn_on = turn_on,
    turn_off = turn_off,
    get_global_enabled_var = get_global_enabled_var,
    setup = setup,
}

