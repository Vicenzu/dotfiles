return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",       -- UI pannelli
      "nvim-neotest/nvim-nio",      -- dipendenza di dap-ui
      "theHamsta/nvim-dap-virtual-text", -- valori inline
    },

    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      require("nvim-dap-virtual-text").setup()
      dapui.setup()

      -- Auto apri/chiudi UI
      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"]     = function() dapui.close() end

      -- Python adapter (richiede: pip install debugpy)
      dap.adapters.python = {
        type = "executable",
        command = "python3",
        args = { "-m", "debugpy.adapter" },
      }
      dap.configurations.python = {{
        type = "python", request = "launch", name = "Launch file",
        program = "${file}",
        pythonPath = function() return vim.fn.exepath("python3") end,
      }}

      -- Java: nvim-java gestisce il DAP automaticamente
      -- Basta usare <leader>dc dopo aver aperto un file Java

      -- JavaScript/TypeScript (richiede: npm i -g @vscode/js-debug)
      dap.adapters["pwa-node"] = {
        type = "server", host = "localhost", port = "${port}",
        executable = {
          command = "node",
          args = { vim.fn.stdpath("data").."/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js", "${port}" },
        },
      }
      dap.configurations.javascript = {{
        type = "pwa-node", request = "launch", name = "Launch file",
        program = "${file}", cwd = "${workspaceFolder}",
      }}
      dap.configurations.typescript = dap.configurations.javascript
    end,
  }
}

