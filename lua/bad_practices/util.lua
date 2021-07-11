local M = {}
function M.print_warn(msg)
    vim.cmd("echohl WarningMsg | echo '" .. msg .. "' | echohl None")
end

return M

