local function print_warn(msg)
    vim.cmd("echohl WarningMsg | echo '" .. msg .. "' | echohl None")
end

local function setup()
    require('bad_practices/tabs_and_spaces').setup()
    require('bad_practices/hjkl').setup()
end


local function turn_off()
    vim.g['bad_practices_enabled'] = 0
end

local function turn_on()
    vim.g['bad_practices_enabled'] = 1
    setup()
end

local function get_global_enabled_var()
    local enabled = vim.g['bad_practices_enabled']
    if enabled ~= nil then
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

