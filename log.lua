local previewers = require("telescope.previewers")
local pickers = require("telescope.pickers")
local sorters = require("telescope.sorters")
local finders = require("telescope.finders")

pickers.new {
    results_title = "Resources",
    -- Run an external command and show the results in the finder window
    finder = finders.new_oneshot_job({"terraform", "show"}),
    sorter = sorters.get_fuzzy_file(),
    previewer = previewers.new_buffer_previewer {
        define_preview = function(self, entry, status)
            -- Execute another command using the highlighted entry
            return require("telescope.previewers.utils").job_maker({
                "terraform", "state", "list", entry.value
            }, self.state.bufnr, {
                callback = function(bufnr, content)
                    if content ~= nil then
                        require("telescope.previewers.utils").regex_highlighter(
                            bufnr, "terraform")
                    end
                end
            })
        end
    }
}:find()