-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- resizing splits
-- these keymaps will also accept a range,
-- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
vim.keymap.set("n", "<A-h>", require("smart-splits").resize_left)
vim.keymap.set("n", "<A-j>", require("smart-splits").resize_down)
vim.keymap.set("n", "<A-k>", require("smart-splits").resize_up)
vim.keymap.set("n", "<A-l>", require("smart-splits").resize_right)
-- moving between splits
vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)
vim.keymap.set("n", "<C-\\>", require("smart-splits").move_cursor_previous)
-- using jk to escape insert mode
vim.keymap.set("i", "jk", "<Esc>", { desc = "Normal mode" })
-- <space>i/I to (i)nterchange function params
vim.keymap.set("n", "<leader>i", function()
  require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
end, { desc = "Swap next argument" })
vim.keymap.set("n", "<leader>I", function()
  require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner")
end, { desc = "Swap previous argument" })
-- map %% to expand current buffer's parent file path
vim.cmd([[cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%']])
-- display dashboard
vim.keymap.set("n", "<leader>xb", function()
  require("snacks").dashboard()
end, { desc = "Display dashboard" })

-- quarto keymaps
local runner = require("quarto.runner")
vim.keymap.set("n", "<localleader>b", "", { desc = "Run Code Block in Markdown", silent = true })
vim.keymap.set("n", "<localleader>bc", runner.run_cell, { desc = "run cell", silent = true })
vim.keymap.set("n", "<localleader>ba", runner.run_above, { desc = "run cell and above", silent = true })
vim.keymap.set("n", "<localleader>bA", runner.run_all, { desc = "run all cells", silent = true })
vim.keymap.set("n", "<localleader>bl", runner.run_line, { desc = "run line", silent = true })
vim.keymap.set("v", "<localleader>bv", runner.run_range, { desc = "run visual range", silent = true })
vim.keymap.set(
  "n",
  "<localleader>bo",
  require("otter").activate,
  { desc = "Activate Otter to enable lsp", silent = true }
)
-- run lua code keymaps
vim.keymap.set("n", "<localleader>l", "", { desc = "Run Lua code", silent = true })
vim.keymap.set("n", "<localleader>ll", ":.lua<cr>", { desc = "Run lua code : current line", silent = true })
vim.keymap.set("v", "<localleader>lv", ":lua<cr>", { desc = "Run lua code : current selection", silent = true })
vim.keymap.set("n", "<localleader>lf", "<cmd>source %<cr>", { desc = "Run lua code : current file", silent = true })
vim.keymap.set("n", "<localleader>lb", "<cmd>so<cr>", { desc = "Run lua code : current buffer", silent = true })
vim.keymap.set("n", "<leader>r", "<cmd>AutoRun<cr>", { desc = "Auto run current buffer", silent = true })

-- User Command for Notebook
-- Provide a command to create a blank new Python notebook
-- note: the metadata is needed for Jupytext to understand how to parse the notebook.
-- if you use another language than Python, you should change it in the template.
local default_notebook = [[
  {
    "cells": [
     {
      "cell_type": "markdown",
      "metadata": {},
      "source": [
        ""
      ]
     }
    ],
    "metadata": {
     "kernelspec": {
      "display_name": "Python 3",
      "language": "python",
      "name": "python3"
     },
     "language_info": {
      "codemirror_mode": {
        "name": "ipython"
      },
      "file_extension": ".py",
      "mimetype": "text/x-python",
      "name": "python",
      "nbconvert_exporter": "python",
      "pygments_lexer": "ipython3"
     }
    },
    "nbformat": 4,
    "nbformat_minor": 5
  }
]]

local function new_notebook(filename)
  local path = filename .. ".ipynb"
  local file = io.open(path, "w")
  if file then
    file:write(default_notebook)
    file:close()
    vim.cmd("edit " .. path)
  else
    print("Error: Could not open new notebook file for writing.")
  end
end

vim.api.nvim_create_user_command("NewNotebook", function(opts)
  new_notebook(opts.args)
end, {
  nargs = 1,
  complete = "file",
})

vim.keymap.set({ "n", "x", "o" }, "]b", function()
  require("nvim-treesitter-textobjects.move").goto_next_start("@code_cell.inner", "textobjects")
end, { desc = "Next Cell" })
vim.keymap.set({ "n", "x", "o" }, "[b", function()
  require("nvim-treesitter-textobjects.move").goto_previous_start("@code_cell.inner", "textobjects")
end, { desc = "Previous Cell" })
vim.keymap.set({ "x", "o" }, "ib", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@code_cell.inner", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ab", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@code_cell.outer", "textobjects")
end)

-- venn.nvim: enable or disable keymappings
function _G.Toggle_venn()
  local venn_enabled = vim.inspect(vim.b.venn_enabled)
  if venn_enabled == "nil" then
    vim.b.venn_enabled = true
    vim.cmd([[setlocal ve=all]])
    -- draw a line on HJKL keystokes
    vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", { noremap = true, silent = true })
    -- draw a box by pressing "f" with visual selection
    vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", { noremap = true, silent = true })
  else
    vim.cmd([[setlocal ve=]])
    vim.api.nvim_buf_del_keymap(0, "n", "J")
    vim.api.nvim_buf_del_keymap(0, "n", "K")
    vim.api.nvim_buf_del_keymap(0, "n", "L")
    vim.api.nvim_buf_del_keymap(0, "n", "H")
    vim.api.nvim_buf_del_keymap(0, "v", "f")
    vim.b.venn_enabled = nil
  end
end
-- toggle keymappings for venn using <leader>v
vim.api.nvim_set_keymap(
  "n",
  "<localleader>v",
  ":lua Toggle_venn()<CR>",
  { desc = "Toggle venn diagram", noremap = true }
)

vim.keymap.set(
  "n",
  "<leader>qr",
  ":lua Snacks.dashboard.pick('oldfiles')<cr>",
  { desc = "Recent Files", silent = true }
)

vim.api.nvim_create_user_command("Plugin", "edit ~/.config/nvim/lua/plugins/" .. "<args>", { nargs = "*" })
