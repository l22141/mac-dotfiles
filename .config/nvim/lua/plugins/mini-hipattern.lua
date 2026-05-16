return {
  "nvim-mini/mini.hipatterns",
  event = "VeryLazy",
  dependencies = { "vandalt/NotebookNavigator.nvim" },
  opts = function(_, opts)
    local nn = require("notebook-navigator")
    opts.highlighters = { cells = nn.minihipatterns_spec }
    return opts
  end,
}
