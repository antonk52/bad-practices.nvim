local M = {}
local utils = require('bad_practices.util')

local function get_default_options(opts)
    local result = {
        most_splits = 5,
        most_tabs = 5,
        max_hjkl = 10,
    }
    for k,v in pairs(opts) do
        result[k] = v
    end

    return result
end

local function validate_option_number(val, name)
    if type(val) ~= 'number' then
        utils.print_warn('bad_practices: "' .. name .. '" is not a number')

        return false
    end

    return val > 0

end

local user_options = get_default_options({})

function M.get_user_options()
    return user_options
end

function M.setup(opts)
    opts = get_default_options(opts or {})
    user_options = opts
    if validate_option_number(opts.max_hjkl, 'max_hjkl') then
        require('bad_practices.hjkl').setup({max_hjkl = opts.max_hjkl})
    end
    if validate_option_number(opts.most_tabs, 'most_tabs') then
        require('bad_practices.tabs').setup()
    end
    if validate_option_number(opts.most_splits, 'most_splits') then
        require('bad_practices.splits').setup()
    end
end

return M
