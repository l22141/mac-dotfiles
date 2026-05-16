return {
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = "VeryLazy",
    opts = {
      move = {
        set_jumps = true,
      },
      select = {
        lookahead = true, -- you can change this if you want
      },
    },
  },
}
