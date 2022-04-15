local Path = require("plenary.path")
local config_path = vim.fn.stdpath("config")
local data_path = vim.fn.stdpath("data")
local user_config = string.format("%s/harpoon.json", config_path)
local cache_config = string.format("%s/harpoon.json", data_path)

local M = {}

-- local popup = require "plenary.popup"

local reversed_list = vim.fn.reverse({"a", "b", "c"})
-- print(vim.inspect(reversed_list)) -- { "c", "b", "a" }

local function read_config(local_config)
    log.trace("_read_config():", local_config)
    return vim.fn.json_decode(Path:new(local_config):read())
end

local function merge_tables(...)
    local out = {}
    for i = 1, select("#", ...) do
        merge_table_impl(out, select(i, ...))
    end
    return out
end

local function merge_table_impl(t1, t2)
    for k, v in pairs(t2) do
        if type(v) == "table" then
            if type(t1[k]) == "table" then
                merge_table_impl(t1[k], v)
            else
                t1[k] = v
            end
        else
            t1[k] = v
        end
    end
end

function M.setup(config)
    print(vim.inspect(config)) -- { "c", "b", "a" }
    print(vim.inspect(user_config)) -- { "c", "b", "a" }
    print(vim.inspect(cache_config)) -- { "c", "b", "a" }

    if not config then
        config = {}
    end

    local ok, u_config = pcall(read_config, user_config)
end

T1 = {
    save_on_toggle = false,
    save_on_change = true,
    enter_on_sendcmd = false,
    tmux_autoclose_windows = false,
    excluded_filetypes = {"harpoon"},
    mark_branch = true
}

T2 = {
    save_on_toggle = false,
    save_on_change = true,
    enter_on_sendcmd = false,
    tmux_autoclose_windows = false,
    excluded_filetypes = {"harpoon"},
    mark_branch = true
}

local after = merge_tables(T1, T2)

print(vim.inspect(after))

M.setup({
    global_settings = {
        save_on_toggle = false,
        save_on_change = true,
        enter_on_sendcmd = false,
        tmux_autoclose_windows = false,
        excluded_filetypes = {"harpoon"},
        mark_branch = true
    }
})
