return {
  {
    "quarto-dev/quarto-nvim",
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    lazy = false,
    opts = {
      lspFeatures = {
        enabled = true,
        languages = { "r", "python", "lua" },
        chunks = "all",
        diagnostics = {
          enabled = true,
          triggers = { "BufWritePost" },
        },
        completion = {
          enabled = true,
        },
      },
      -- keymap = {
      --   hover = "H",
      --   definition = "gd",
      --   rename = "<leader>rn",
      --   references = "gr",
      --   format = "<leader>gf",
      -- },
      codeRunner = {
        enabled = true,
        default_method = "molten",
      },
      -- ft = { "quarto", "markdown" },
    },
  },
  {
    "jmbuhr/otter.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    lazy = false,
    opts = {
      buffers = {
        set_filetype = true,
        write_to_disk = true,
      },
    },
    config = true,
  },
}
