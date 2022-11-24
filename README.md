# Ruby on Rail on Neovim (RORON)

- A simple lua plugin for using RoR 
- mainly a wrapper for certain terminal commands with integrated 'finders' that try to find the root dir for running commands
- provides a few user commands that are extremely customizable for making your own workflow

## Commands 

#### RailsCommand

- RailsCommand
  - position (H, J, K, L)
  - project rails (true, false)
  - command

#### RailsTestFile

- takes no argurments tests the current file only!
- to test entire project you can create your own keybindings using something like the following in a ruby autocmd

```
nnoremap <silent><buffer> <Space>rc :RailsCommand J true test<CR>
```

#### LoadIRB

- start lua repl with current ruby file loaded in
- LoadIRB
  - position (H, J, K, L)

## Default Keybindings

- can be set or unset with the following 

```lua
vim.g.roron_autos = true -- default bindings

-- or set false and use your own
```

## Testing Files

### Passing Test
![](imgs/passedTest.jpeg)

### Failing Test Report
![](imgs/failedTest.jpeg)

### Error Marks on Failing Test
![](imgs/errorMarks.jpeg)
