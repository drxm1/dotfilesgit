return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarringa/nvim-dap-ui",
    "mfussenegger/nvim-dap-python",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    dap.set_log_level("TRACE")
    dapui.setup()
    local dap_python = require("dap-python")
    dap_python.setup("~/venvs/data_analysis/bin/python")

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    vim.keymap.set("n", "<leader>db", function()
      require("dap").toggle_breakpoint()
    end)
    vim.keymap.set("n", "<leader>dc", function()
      require("dap").continue()
    end)
    vim.keymap.set("n", "<leader>do", function()
      require("dap").step_out()
    end)
  end,
}
