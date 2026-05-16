local M = {}
-- 默认配置：定义不同后缀文件的编译与运行命令
-- {file} 代表当前文件的绝对路径，{file_no_ext} 代表不含后缀的绝对路径
local config = {
  runners = {
    py = {
      run = "python3 {file}",
    },
    cpp = {
      compile = "clang++-mp-21 -std=c++23 -stdlib=libc++ -mmacosx-version-min=13.3 -isysroot $(xcrun --show-sdk-path) -L/opt/local/libexec/llvm-21/lib/libc++ -Wl,-rpath,/opt/local/libexec/llvm-21/lib -Wl,-rpath,/opt/local/libexec/llvm-21/lib/libc++ -Wl,-rpath,/opt/local/libexec/llvm-21/lib/libunwind {file} -o {file_no_ext}",
      run = "{file_no_ext}",
    },
    c = {
      compile = "gcc {file} -o {file_no_ext}",
      run = "{file_no_ext}",
    },
    js = {
      run = "node {file}",
    },
    go = {
      run = "go run {file}",
    },
    rs = {
      compile = "rustc {file} -o {file_no_ext}",
      run = "{file_no_ext}",
    },
    ts = {
      run = "tsx {file}",
    },
    lua = {
      run = "lua {file}",
    },
    -- 可以在此继续添加更多语言的支持
  },
}
-- 设置函数，允许用户自定义覆盖或新增运行规则
-- function M.setup(user_config)
--     if user_config and user_config.runners then
--         for ext, cmds in pairs(user_config.runners) do
--             config.runners[ext] = cmds
--         end
--     end
-- end
-- 替换命令中的占位符
local function parse_cmd(cmd, filepath)
  local filenoext = filepath:match("(.*)(%..-)$") or filepath
  -- 兼容 Windows 下可执行文件需要 .exe 后缀的情况
  if vim.fn.has("win32") == 1 and not filenoext:match("%.exe$") then
    filenoext = filenoext .. ".exe"
  end
  return cmd:gsub("{file}", filepath):gsub("{file_no_ext}", filenoext)
end
-- 异步执行命令
local function run_command(cmd, callback)
  local output = {}
  vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    stderr_buffered = true,
    on_stdout = function(_, data)
      vim.list_extend(output, data)
    end,
    on_stderr = function(_, data)
      vim.list_extend(output, data)
    end,
    on_exit = function(_, code)
      if code ~= 0 then
        table.insert(output, "\n[Process exited with code: " .. code .. "]")
      end
      callback(output, code)
    end,
  })
end
-- 在浮动窗口中显示结果
local function show_output(lines)
  -- 清理空行
  local clean_lines = {}
  for _, line in ipairs(lines) do
    line = line:gsub("[\r\n]", "")
    if line ~= "" then
      table.insert(clean_lines, line)
    end
  end
  if #clean_lines == 0 then
    table.insert(clean_lines, "[No output]")
  end
  -- 创建缓冲区
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, clean_lines)
  -- vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
  -- vim.api.nvim_buf_set_option(buf, "filetype", filetype or "log")
  -- 设置浮动窗口大小与位置
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)
  local opts = {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal",
    border = "rounded",
    title = " AutoRun Output ",
    title_pos = "center",
  }
  -- 打开浮动窗口
  local win = vim.api.nvim_open_win(buf, true, opts)
  -- vim.api.nvim_win_set_option(win, "winhl", "Normal:Normal,FloatBorder:WarningMsg")
  -- 映射 q 键快速关闭浮动窗口
  vim.api.nvim_buf_set_keymap(buf, "n", "q", "<cmd>close<CR>", { silent = true, noremap = true })
end
-- 主运行逻辑
function M.run()
  -- 自动保存当前文件
  vim.cmd("silent! update")
  local filepath = vim.fn.expand("%:p")
  local ext = vim.fn.expand("%:e")
  local runner = config.runners[ext]
  if not runner then
    vim.notify("No runner configured for extension: ." .. ext, vim.log.levels.WARN)
    return
  end
  -- 如果需要先编译
  if runner.compile then
    local compile_cmd = parse_cmd(runner.compile, filepath)
    vim.notify("Compiling: " .. compile_cmd, vim.log.levels.INFO)
    run_command(compile_cmd, function(output, code)
      if code ~= 0 then
        -- 编译失败，输出错误信息
        -- vim.notify("Compilation failed!", vim.log.levels.ERROR)
        table.insert(output, 1, "Compilation failed!")
        show_output(output)
      else
        -- 编译成功，继续运行
        local run_cmd = parse_cmd(runner.run, filepath)
        -- vim.notify("Running: " .. run_cmd, vim.log.levels.INFO)
        run_command(run_cmd, function(run_output, run_code)
          table.insert(run_output, 1, "Running: " .. run_cmd)
          show_output(run_output)
        end)
      end
    end)
  else
    -- 如果不需要编译，直接运行
    local run_cmd = parse_cmd(runner.run, filepath)
    -- vim.notify("Running: " .. run_cmd, vim.log.levels.INFO)
    run_command(run_cmd, function(output, code)
      table.insert(output, 1, "Running: " .. run_cmd)
      show_output(output)
    end)
  end
end
vim.api.nvim_create_user_command("AutoRun", function()
  M.run()
end, { desc = "Run current file based on its extension" })
