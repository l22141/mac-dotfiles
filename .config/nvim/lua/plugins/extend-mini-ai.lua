return {
  {
    "nvim-mini/mini.ai",
    event = "VeryLazy",
    enabled = true,
    dependencies = { "vandalt/NotebookNavigator.nvim" },
    opts = function(_, opts)
      local nn = require("notebook-navigator")
      opts.custom_textobjects.h = nn.miniai_spec
      return opts
    end,
  },
}
