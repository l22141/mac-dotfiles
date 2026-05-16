return {
  {
    "GCBallesteros/NotebookNavigator.nvim",
    keys = {
      {
        "]h",
        function()
          require("notebook-navigator").move_cell("d")
        end,
      },
      {
        "[h",
        function()
          require("notebook-navigator").move_cell("u")
        end,
      },
      { "<localleader>mc", "<cmd>lua require('notebook-navigator').run_cell()<cr>" },
      { "<localleader>mC", "<cmd>lua require('notebook-navigator').run_and_move()<cr>" },
    },
    dependencies = {
      "benlubas/molten-nvim",
      "nvimtools/hydra.nvim",
    },
    event = "VeryLazy",
    opts = {
      activate_hydra_keys = "<localleader>h",
      syntax_highlight = true,
      show_hydra_hint = true,
    },
  },
  {
    "nvimtools/hydra.nvim",
  },
}
