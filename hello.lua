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
    log.trace("_merge_tables()")
    local out = {}
    for i = 1, select("#", ...) do
        merge_table_impl(out, select(i, ...))
    end
    return out
end

function M.setup(config)
    print(vim.inspect(config)) -- { "c", "b", "a" }
    print(vim.inspect(user_config)) -- { "c", "b", "a" }
    print(vim.inspect(cache_config)) -- { "c", "b", "a" }

    if not config then
        config = {}
    end

    local ok, u_config = pcall(read_config, user_config)
    --
    -- if not ok then
    --     log.debug("setup(): No user config present at", user_config)
    --     u_config = {}
    -- end
    --
    -- local ok2, c_config = pcall(read_config, cache_config)
    --
    -- if not ok2 then
    --     log.debug("setup(): No cache config present at", cache_config)
    --     c_config = {}
    -- end
    --
    -- local complete_config = merge_tables({
    --     projects = {},
    --     global_settings = {
    --         ["save_on_toggle"] = false,
    --         ["save_on_change"] = true,
    --         ["enter_on_sendcmd"] = false,
    --         ["tmux_autoclose_windows"] = false,
    --         ["excluded_filetypes"] = {"harpoon"},
    --         ["mark_branch"] = false
    --     }
    -- }, expand_dir(c_config), expand_dir(u_config), expand_dir(config))
    --
    -- -- There was this issue where the vim.loop.cwd() didn't have marks or term, but had
    -- -- an object for vim.loop.cwd()
    -- ensure_correct_config(complete_config)
    --
    -- HarpoonConfig = complete_config
    -- log.debug("setup(): Complete config", HarpoonConfig)
    -- log.trace("setup(): log_key", Dev.get_log_key())
end

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

local function expand_dir(config)
    log.trace("_expand_dir(): Config pre-expansion:", config)

    local projects = config.projects or {}
    for k in pairs(projects) do
        local expanded_path = Path.new(k):expand()
        projects[expanded_path] = projects[k]
        if expanded_path ~= k then
            projects[k] = nil
        end
    end

    log.trace("_expand_dir(): Config post-expansion:", config)
    return config
end
