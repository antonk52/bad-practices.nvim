local utils = require('bad_practices/util')
local COUNTERS = {
    h = 0,
    j = 0,
    k = 0,
    l = 0,
}
local MAX_CHARS = 10
local _DEBUG = false
local global_optiona_name = 'bad_practices_max_hjkl'

if vim.fn.exists('g:'..global_optiona_name) == 1 then
    local g_chars = vim.g[global_optiona_name]
    if type(g_chars) == 'number' then
        MAX_CHARS = g_chars
    else
        if _DEBUG == true then
            print('"g:'..global_optiona_name..'" is set to non number value "'..g_chars..'"')
        end
    end
end

local KEYS_TO_MAP = {
    basic_move = {'h', 'j', 'k', 'l'},
    better_move = {'w', 'W', 'e', 'E', 'f', 'F', 't', 'T', 'b', 'B'},
    advanced_move = {'/', '?', 'n', 'N', '{', '}'},
}

local function setup()
    local mode = 'n'
    local options = {silent = true, noremap = true}
    -- set spy mappings for hjkl
    for _,key in pairs(KEYS_TO_MAP.basic_move) do
        vim.api.nvim_set_keymap(
            mode,
            key,
            key..':lua require("bad_practices/hjkl").inc("'..key..'")<CR>',
            options
        )
    end
    -- TODO reset counters on other movements
    -- [x] weftb - multichar movements should reset counters
    -- [x] /? - search should reset counters
    -- [x] {}
    for _,key in pairs(KEYS_TO_MAP.better_move) do
        vim.api.nvim_set_keymap(
            'n',
            key,
            ':lua require("bad_practices/hjkl").reset_all()<CR>:echo<CR>'..key,
            {unique = true, noremap = true}
        )
    end

    for _,key in pairs(KEYS_TO_MAP.advanced_move) do
        vim.api.nvim_set_keymap(
            'n',
            key,
            ':lua require("bad_practices/hjkl").reset_all()<CR>:echo<CR>'..key,
            {unique = true, noremap = true}
        )
    end

    -- todo autocmd to reset counters on InsertEnter
    if _DEBUG == true then print('hjkl mappings are set') end
end

local function reset_all()
    COUNTERS = {
        h = 0,
        j = 0,
        k = 0,
        l = 0,
    }
    if _DEBUG == true then print('reset_all()') end
end

local function unset()
    reset_all()
    for _,keys in pairs(KEYS_TO_MAP) do
        for _,key in pairs(keys) do
            vim.api.nvim_del_keymap('n', key)
        end
    end
end

-- todo check for other items overload prior to increment
local function inc(key)
    if utils.get_global_enabled_var() == false then
        unset()
        return 1
    end
    for _,v in pairs(KEYS_TO_MAP.basic_move) do
        if key == v then
            COUNTERS[v] = COUNTERS[v] + 1
        else
            local count = COUNTERS[v]
            if (count > MAX_CHARS) then
                utils.print_warn(
                    'You pressed '..v..' '..count..' times in a row, consider other movements. :help movement'
                )
            end
            COUNTERS[v] = 0
        end
    end
end

return {
    setup = setup,
    inc = inc,
    reset_all = reset_all,
}
