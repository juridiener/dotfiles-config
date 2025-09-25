return {
  {
    "mfussenegger/nvim-dap",
    dependencies = { "mason-org/mason.nvim" },
    opts = function()
      local dap = require("dap")

      -- Node.js adapter
      dap.adapters.node2 = {
        type = "executable",
        command = "node",
        host = "localhost",
        port = 9229,
        executable = {
          command = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug-adapter",
          -- args = { "9229" },
        },
      }

      local workspace_folder = "/Users/juri.diener/Documents/projects/hains/hains_docker"

      dap.configurations.typescript = {
        {
          type = "node2",
          request = "attach",
          name = "Attach to API (Docker)",
          port = 9229,
          address = "localhost",
          localRoot = workspace_folder .. "/monorepo/my_workspace",
          remoteRoot = "/app",
          restart = true,
          sourceMaps = true,
          skipFiles = { "<node_internals>/**" },
          timeout = 60000,
          cwd = workspace_folder .. "/monorepo/my_workspace",
          env = { WORKSPACE_FOLDER = workspace_folder },
          sourceMapPathOverrides = {
            ["webpack:///./src/*"] = "${workspaceFolder}/apps/api/src/*",
            ["webpack:///src/*"] = "${workspaceFolder}/apps/api/src/*",
            ["webpack:///./libs/*"] = "${workspaceFolder}/libs/*",
            ["webpack:///libs/*"] = "${workspaceFolder}/libs/*",
            ["../src/*"] = "${workspaceFolder}/apps/api/src/*",
            ["../libs/*"] = "${workspaceFolder}/libs/*",
            ["webpack:///../../libs/*"] = "${workspaceFolder}/libs/*",
            ["webpack:///../../libs/models/src/lib/dienstwunsch.ts"] = "${workspaceFolder}/libs/models/src/lib/dienstwunsch.ts",
          },
          trace = true,
          outFiles = { "${workspaceFolder}/dist/apps/api/**/*.js" },
          protocol = "inspector",
          console = "integratedTerminal",
        },
      }

      dap.set_log_level("TRACE")
      vim.g.dap_log_file = "/tmp/dap.log"

      dap.listeners.after["event_initialized"]["my_debug"] = function(session, body)
        print("DAP Initialized! Debugger attached.")
        print(vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug-adapter")
      end
      dap.listeners.after["event_breakpoint"]["my_debug"] = function(session, body)
        print("Breakpoint hit: " .. vim.inspect(body))
      end
      dap.listeners.after["event_terminated"]["my_debug"] = function(session, body)
        print("DAP Terminated!")
      end
    end,
  },
}
