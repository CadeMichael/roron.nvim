vim.api.nvim_create_autocmd(
  "FileType",
  {
    pattern = {
      "ruby",
    },
    command = [[
    nnoremap <silent><buffer> <Space>Lb :LoadIRB J<CR>
    nnoremap <silent><buffer> <Space>Ls :LoadIRB L<CR>
    nnoremap <silent><buffer> <Space>rc :RailsCommand J true console --sandbox<CR>
    nnoremap <silent><buffer> <Space>rr :RailsCommand J true server<CR>
    nnoremap <silent><buffer> <Space>rt :RailsTestFile<CR>
    ]],
  }
)
