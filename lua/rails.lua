-- get helper functions
local help = require('helperFuncs')

-- open rails console in sandbox
function RailsCommand(pos, proj_rails, cmd)
  -- init variables
  local dir
  local command
  -- get project root dir
  local lsp_dir = vim.lsp.buf.list_workspace_folders()[1]
  -- if user wants proj specific rails
  if proj_rails then
    -- allow user to modify root dir
    dir = vim.fn.input("Directory=> ", lsp_dir, "file")
    command = dir .. "/bin/rails "
  else
    command = "rails "
  end
  -- create new window
  vim.cmd(":wincmd n")
  vim.cmd(":wincmd " .. pos)
  -- run command
  vim.fn.termopen(command .. cmd)
end

-- create user command
vim.api.nvim_create_user_command("RailsCommand",
  function(opts)
    RailsCommand(opts.fargs[1], -- position
      opts.fargs[2], -- proj rails
      opts.fargs[3]) -- rails command
  end, { nargs = '+' })

-- open ruby repl with current file loaded
function LoadIRB(pos)
  -- get buffer name
  local buf = vim.api.nvim_buf_get_name(0)
  -- make and move to window
  vim.cmd(":wincmd n")
  vim.cmd(":wincmd " .. pos)
  -- load file into terminal
  local command = "irb -r " .. buf
  vim.fn.termopen(command)
end

-- create user command
vim.api.nvim_create_user_command("LoadIRB",
  function(opts)
    LoadIRB(opts.args) -- positions
  end, { nargs = 1 })

-- Test the current rails file
function RailsTestFile()
  -- get variables from helper func
  local vars = help.runProjRails()
  local rails = vars[1]
  local root = vars[2]
  -- messages to user
  print("Run a Test File...\n")
  print("Project root => " .. root .. "\n")
  -- get current file (should be a test file)
  local cur_file = vim.api.nvim_buf_get_name(0)
  -- get relative (to root dir) path of test file
  local test_file = help.splitFile(cur_file, "test")
  -- see if file is in 'test/' dir
  if test_file == nil then
    print('not a test file !')
    -- break out of function
    return
  end
  -- compose command
  local command = rails .. " test -v " .. test_file
  local regex = '.rb:[0-9]+'
  local success = 'Running'
  -- check rails being used
  if #rails ~= 9 then
    -- set dir before command
    command = 'cd ' .. root .. ' && ' .. command
    print('File: ' .. test_file)
    help.markFailed(command, root, success, regex)
    -- rails exe is in current dir
  else
    print(test_file)
    help.markFailed(command, root, success, regex)
  end
end

-- create user command
vim.api.nvim_create_user_command("RailsTestFile",
  function()
    RailsTestFile()
  end, {})
