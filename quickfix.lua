print("Hello World")

-- local g = vim.g
-- local cmd = vim.api.nvim_command

local tg_quickfix_local = 0
local tg_quickfix_global = 0

function ToggleQFList(global)
    if global == 1 then
        if tg_quickfix_global == 1 then
            print("Hello World")
            -- g.tg_quickfix_global = 0
            -- cmd "cclose"
        else
            print("Hello World 2")
            -- g.tg_quickfix_global = 1
            -- cmd "copen"
        end
    else
        if tg_quickfix_local == 1 then
            print("Hello World 3")
            -- g.tg_quickfix_local = 0
            -- cmd "lclose"
        else
            print("Hello World 4")
            -- g.tg_quickfix_local = 1
            -- cmd "lopen"
        end
    end
end
ToggleQFList(1)
