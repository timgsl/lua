local config_path = vim.fn.stdpath("config")
local data_path = vim.fn.stdpath("data")
local user_config = string.format("%s/harpoon.json", config_path)
local cache_config = string.format("%s/harpoon.json", data_path)
local testfile1 = "~/src/playground/lua/harpoon/h1.json"
local testfile2 = "~/src/playground/lua/harpoon/h2.json"
-- print(testfile)
local Path = require("plenary.path")

local j1 = vim.fn.json_decode(Path:new(testfile1):read())
local j2 = vim.fn.json_decode(Path:new(testfile2):read())

-- print("j1 " .. vim.inspect(j1))
-- print("j2 " .. vim.inspect(j2))

-- local ok, u_config = pcall(read_config, cache_config)

-- print(vim.inspect(u_config))

-- for k in pairs(projects) do
--     local expanded_path = Path.new(k):expand()
--     projects[expanded_path] = projects[k]
--     if expanded_path ~= k then
--         projects[k] = nil
--     end
-- end
--

local function expand_dir(config)

    local projects = config.projects or {}
    for k in pairs(projects) do
        -- print("this is " .. k)
        local expanded_path = Path.new(k):expand()
        -- print("this is expanded_path " .. expanded_path)
        projects[expanded_path] = projects[k]
        if expanded_path ~= k then
            -- print("expanded path ~= k" .. "|k------" .. k .. "\n|exp-----"
            -- .. expanded_path)
            -- print("\n")
            projects[k] = nil
        end
    end

    return config
end

local expanded = expand_dir(j1)

local function merge_table_impl(t1, t2)
    print(' ')
    print('merge table impl' .. '---------')
    print('t1 is ' .. vim.inspect(t1))
    print('t2 is ' .. vim.inspect(t2))
    for k, v in pairs(t2) do
        print("  START: for each k of t2: t1 " .. k .. " is " .. vim.inspect(t1[k]) .. ' ......................... ┬──┬◡ﾉ(° -°ﾉ)')
        if (k == 'base_dirs') then
            t1[k] = v
        end
        if type(v) == "table" then
            print("     t2 " .. k .. " is a table") 
            if type(t1[k]) == "table" then
                print("     t1 " .. k .. " is a table") 
                print("     merge again!") 
                merge_table_impl(t1[k], v)
            else
                print("     t1 " .. k .. " is not a table") 
                t1[k] = v
            end
        else
                print("     t2 " .. k .. " is not a table") 
            t1[k] = v
        end
        print("  END: for each k of t2: t1 " .. k .. " is now " .. vim.inspect(t1[k]))
    end
end

local function merge_tables(...)
    local out = {}
    -- print(">>>>>>>" .. vim.inspect(select("#", ...)))
    for i = 1, select("#", ...) do
        print(' ')
        print("OUTER LOOP: MERGE_TABLES " .. i .. '=============================')
        merge_table_impl(out, select(i, ...))
        print(" " )
        print("OUT is" .. vim.inspect(out))
    end
    print(vim.inspect(out))
    return out
end

local complete_config = merge_tables({
    projects = {},
    global_settings = { base_dirs = {"a","b"}}
}, expand_dir(j1))
-- local t = merge_tables({projects = {}}, {test = {}})

-- print(vim.inspect(t))
--

