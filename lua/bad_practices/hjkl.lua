local utils = require('bad_practices/util')
local M = {}
local COUNTERS = {
    h = 0,
    j = 0,
    k = 0,
    l = 0,
}

local KEYS_TO_MAP = {
    basic_move = {'h', 'j', 'k', 'l'},
    better_move = {'w', 'W', 'e', 'E', 'f', 'F', 't', 'T', 'b', 'B'},
    advanced_move = {'/', '?', 'n', 'N', '{', '}'},
}

function M.setup(opts)
    opts = opts or {}
    local max_hjkl = opts.max_hjkl
    if not type(max_hjkl) == 'number' then
        print('bad_practices: max_hjkl is not a number')
        return nil
    end
    local mode = 'n'
    local options = {silent = true, noremap = true}
    -- set spy mappings for hjkl
    for _,key in pairs(KEYS_TO_MAP.basic_move) do
        vim.api.nvim_set_keymap(
            mode,
            key,
            key..':lua require("bad_practices/hjkl").inc("'..key..'", '..max_hjkl..')<CR>',
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
end

function M.reset_all()
    COUNTERS = {
        h = 0,
        j = 0,
        k = 0,
        l = 0,
    }
end

local function unset()
    M.reset_all()
    for _,keys in pairs(KEYS_TO_MAP) do
        for _,key in pairs(keys) do
            vim.api.nvim_del_keymap('n', key)
        end
    end
end

-- todo check for other items overload prior to increment
function M.inc(key, max_hjkl)
    if utils.get_global_enabled_var() == false then
        unset()
        return 1
    end
    for _,v in pairs(KEYS_TO_MAP.basic_move) do
        if key == v then
            COUNTERS[v] = COUNTERS[v] + 1
        else
            local count = COUNTERS[v]
            if (count > max_hjkl) then
                utils.print_warn(
                    'You pressed '..v..' '..count..' times in a row, consider other movements. :help movement'
                )
            end
            COUNTERS[v] = 0
        end
    end
end

return M
