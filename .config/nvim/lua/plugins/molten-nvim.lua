return {
  {
    "benlubas/molten-nvim",
    version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    -- dependencies = { "3rd/image.nvim" },
    build = ":UpdateRemotePlugins",
    init = function()
      -- these are examples, not defaults. Please see the readme
      -- vim.g.molten_image_provider = "image.nvim"
      -- vim.g.molten_output_win_max_height = 20
      -- molten keymaps
      vim.keymap.set("n", "<localleader>m", "", { desc = "Molten run code with jupyter", silent = true })
      vim.keymap.set("n", "<localleader>mi", ":MoltenInit<CR>", { silent = true, desc = "Molten Initialize" })
      vim.keymap.set("n", "<localleader>md", ":MoltenDelete<CR>", { silent = true, desc = "Delete molten cell" })
      vim.keymap.set("n", "<localleader>mo", ":MoltenEvaluateOperator<CR>", { silent = true, desc = "Run Operator" })
      vim.keymap.set("n", "<localleader>mr", ":MoltenReevaluateCell<CR>", { silent = true, desc = "Re-evaluate cell" })
      vim.keymap.set("n", "<localleader>ml", ":MoltenEvaluateLine<CR>", { silent = true, desc = "Evaluate line" })
      vim.keymap.set(
        "v",
        "<localleader>mv",
        ":<C-u>MoltenEvaluateVisual<CR>gv",
        { silent = true, desc = "Evaluate visual selection" }
      )
      vim.keymap.set(
        "n",
        "<localleader>ms",
        ":noautocmd MoltenEnterOutput<CR>",
        { silent = true, desc = "Show/Enter output" }
      )
      vim.keymap.set("n", "<localleader>mh", ":MoltenHideOutput<CR>", { silent = true, desc = "Hide output" })
    end,
  },
}
