return {
  {
    "nvim-mini/mini.move",
    enabled = true,
    version = false,
    config = function()
      local ok_hydra, Hydra = pcall(require, "hydra")
      if not ok_hydra then
        vim.notify("hydra not installed...", vim.log.ERROR)
        return
      end

      local ok_minimove, minimove = pcall(require, "mini.move")
      assert(ok_minimove)
      if ok_minimove == true then
        local opts = {
          mappings = {
            left = "",
            right = "",
            down = "",
            up = "",
            line_left = "",
            line_right = "",
            line_down = "",
            line_up = "",
          },
        }
        minimove.setup(opts)
        -- setup here prevents needless global vars for opts required by `move_selection()/moveline()`
        local selmove_hint = [[
      Arrow^^^^^^
      ^ ^ _k_ ^ ^
      _h_ ^ ^ _l_
      ^ ^ _j_ ^ ^                      _<C-c>_
      ]]
        Hydra({
          name = "Move Box Selection",
          hint = selmove_hint,
          config = {
            color = "pink",
            invoke_on_body = true,
          },
          mode = "v",
          body = "<leader>vs",
          heads = {
            {
              "h",
              function()
                minimove.move_selection("left", opts)
              end,
            },
            {
              "j",
              function()
                minimove.move_selection("down", opts)
              end,
            },
            {
              "k",
              function()
                minimove.move_selection("up", opts)
              end,
            },
            {
              "l",
              function()
                minimove.move_selection("right", opts)
              end,
            },
            { "<C-c>", nil, { exit = true } },
          },
        })
        local line_move_hint = [[
      Arrow^^^^^^
      ^ ^ _k_ ^ ^
      _h_ ^ ^ _l_
      ^ ^ _j_ ^ ^                      _<C-c>_
      ]]
        Hydra({
          name = "Move Line Selection",
          hint = line_move_hint,
          config = {
            color = "pink",
            invoke_on_body = true,
          },
          mode = "n",
          body = "<leader>vl",
          heads = {
            {
              "h",
              function()
                minimove.move_line("left", opts)
              end,
            },
            {
              "j",
              function()
                minimove.move_line("down", opts)
              end,
            },
            {
              "k",
              function()
                minimove.move_line("up", opts)
              end,
            },
            {
              "l",
              function()
                minimove.move_line("right", opts)
              end,
            },
            { "<C-c>", nil, { exit = true } },
          },
        })
      end
    end,
  },
}
