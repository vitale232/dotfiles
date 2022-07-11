local function file_exists(file_path)
    local f = io.open(file_path)
    if f ~= nil then
        io.close(f)
        return true
    else return false
    end
end

local function find_buf(file_path)
    local buf_id = vim.fn.bufnr(file_path, false)
    local is_existing_file = true
    if buf_id == -1 then
        is_existing_file = file_exists(file_path)
    end
    if is_existing_file == true then
        buf_id = vim.fn.bufnr(file_path, true)
        return buf_id
    else
        return -1
    end
end

local function open_buf(buf_id)
        vim.api.nvim_set_current_buf(buf_id)
        vim.api.nvim_buf_set_option(buf_id, "buflisted", true)
end

local function switch_to(new_ext)
    local curr_path = vim.fn.expand("%")
    local new_path
    if curr_path == nil then
        new_path = curr_path .. "." .. new_ext
    else
        new_path = curr_path:gsub("[^.]+$", new_ext)
    end
    local buf_id = find_buf(new_path)
    if buf_id > -1 then
        open_buf(buf_id)
    else
        vim.ui.input(
            { prompt = " No source file exists. Create it? (yes / y / sure / ok / okay): " },
            function(input)
                if input == nil then
                    print(" :: Nothing created, bye! 👋")
                    return -1
                end
                for _, value in ipairs({ 'yes', 'y', 'sure', 'ok', 'okay'}) do
                    if string.lower(input) == value then
                        buf_id = vim.fn.bufnr(new_path, true)
                        open_buf(buf_id)
                        return buf_id
                    end
                end
                print(" :: Nothing created, bye! 👋")
            end
        )
    end
end

return {
    switch_to = switch_to
}

