return {
  {
    "GCBallesteros/jupytext.nvim",
    config = true,
    -- enabled = false,
    lazy = false,
    dependencies = {
      "jmbuhr/otter.nvim",
    },
    opts = {
      -- cutom_language_formatting = {
      --   python = {
      --     extension = "md",
      --     style = "markdown",
      --     force_ft = "markdown",
      --   },
      -- },
      style = "markdown",
      output_extension = "md",
      force_ft = "markdown",
    },
  },
}
