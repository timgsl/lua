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

print("j1 " .. vim.inspect(j1))
print("j2 " .. vim.inspect(j2))

-- local ok, u_config = pcall(read_config, cache_config)

print(vim.inspect(config_path))
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
        print("this is " .. k)
        local expanded_path = Path.new(k):expand()
        print("this is expanded_path " .. expanded_path)
        projects[expanded_path] = projects[k]
        if expanded_path ~= k then
            print("expanded path ~= k" .. "|k------" .. k .. "\n|exp-----"
                      .. expanded_path)
            print("\n")
            projects[k] = nil
        end
    end

    return config
end

local expanded = expand_dir(j1)
print("expanded " .. vim.inspect(expanded))
