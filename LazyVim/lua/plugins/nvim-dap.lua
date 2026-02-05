-- ============================================================================
-- NeoVim DAP (Debug Adapter Protocol) Configuration
-- ============================================================================
-- This configuration sets up debugging for TypeScript/JavaScript in a NestJS
-- monorepo running in Docker. It supports:
--   - Attaching to Node.js process running in Docker (port 9229)
--   - Breakpoints in monorepo structure (apps/api, libs/prisma_cruds, etc.)
--   - Source map resolution for webpack-compiled code
--   - Conditional breakpoints
--   - DAP UI with auto-open/close
--   - Virtual text showing variable values inline
-- ============================================================================

return {
  -- ============================================================================
  -- Main DAP Plugin
  -- ============================================================================
  {
    "mfussenegger/nvim-dap",
    dependencies = { "mason-org/mason.nvim" },
    lazy = false,  -- Load immediately so keybindings work
    
    -- ============================================================================
    -- Configuration Function
    -- ============================================================================
    config = function()
      local dap = require("dap")
      
      -- ========================================================================
      -- Setup Keybindings
      -- ========================================================================
      -- F-Key Bindings (Standard Debugging Controls)
      vim.keymap.set("n", "<F5>", function() dap.continue() end, { desc = "Debug: Start/Continue" })
      vim.keymap.set("n", "<F9>", function() dap.toggle_breakpoint() end, { desc = "Debug: Toggle Breakpoint" })
      vim.keymap.set("n", "<F10>", function() dap.step_over() end, { desc = "Debug: Step Over" })
      vim.keymap.set("n", "<F11>", function() dap.step_into() end, { desc = "Debug: Step Into" })
      vim.keymap.set("n", "<F12>", function() dap.step_out() end, { desc = "Debug: Step Out" })
      
      -- Leader Key Bindings (Advanced Features)
      vim.keymap.set("n", "<leader>db", function() require("dapui").toggle() end, { desc = "Debug: Toggle UI" })
      vim.keymap.set("n", "<leader>dr", function() dap.repl.toggle() end, { desc = "Debug: Toggle REPL" })
      vim.keymap.set("n", "<leader>dl", function() dap.run_last() end, { desc = "Debug: Run Last" })
      
      -- Conditional breakpoint
      vim.keymap.set("n", "<leader>dB", function()
        vim.ui.input({ prompt = "Breakpoint condition: " }, function(condition)
          if condition then
            dap.set_breakpoint(condition)
          end
        end)
      end, { desc = "Debug: Conditional Breakpoint" })
      
      -- Log point
      vim.keymap.set("n", "<leader>dL", function()
        vim.ui.input({ prompt = "Log point message: " }, function(message)
          if message then
            dap.set_breakpoint(nil, nil, message)
          end
        end)
      end, { desc = "Debug: Log Point" })
      
      vim.keymap.set("n", "<leader>dc", function() dap.run_to_cursor() end, { desc = "Debug: Run to Cursor" })
      vim.keymap.set("n", "<leader>dt", function() dap.terminate() end, { desc = "Debug: Terminate" })
      vim.keymap.set("n", "<leader>dh", function() require("dap.ui.widgets").hover() end, { desc = "Debug: Hover" })
      vim.keymap.set("n", "<leader>dp", function() require("dap.ui.widgets").preview() end, { desc = "Debug: Preview" })
      
      -- ========================================================================
      -- Breakpoint Signs Configuration
      -- ========================================================================
      -- Define visual indicators for breakpoints in the sign column
      vim.fn.sign_define('DapBreakpoint', {
        text = '🔴',  -- Red circle for breakpoint
        texthl = 'DapBreakpoint',
        linehl = '',
        numhl = 'DapBreakpoint'
      })
      
      vim.fn.sign_define('DapBreakpointCondition', {
        text = '🟡',  -- Yellow circle for conditional breakpoint
        texthl = 'DapBreakpointCondition',
        linehl = '',
        numhl = 'DapBreakpointCondition'
      })
      
      vim.fn.sign_define('DapBreakpointRejected', {
        text = '⚫',  -- Grey circle for rejected/unverified breakpoint
        texthl = 'DapBreakpointRejected',
        linehl = '',
        numhl = 'DapBreakpointRejected'
      })
      
      vim.fn.sign_define('DapLogPoint', {
        text = '📝',  -- Notepad for log point
        texthl = 'DapLogPoint',
        linehl = '',
        numhl = 'DapLogPoint'
      })
      
      vim.fn.sign_define('DapStopped', {
        text = '▶️',  -- Arrow for current execution line
        texthl = 'DapStopped',
        linehl = 'DapStoppedLine',
        numhl = 'DapStopped'
      })
      
      -- Set highlight colors for breakpoints
      vim.api.nvim_set_hl(0, 'DapBreakpoint', { fg = '#e51400' })  -- Red
      vim.api.nvim_set_hl(0, 'DapBreakpointCondition', { fg = '#ffcc00' })  -- Yellow
      vim.api.nvim_set_hl(0, 'DapBreakpointRejected', { fg = '#777777' })  -- Grey
      vim.api.nvim_set_hl(0, 'DapLogPoint', { fg = '#61afef' })  -- Blue
      vim.api.nvim_set_hl(0, 'DapStopped', { fg = '#00ff00' })  -- Green
      vim.api.nvim_set_hl(0, 'DapStoppedLine', { bg = '#2e4d2e' })  -- Dark green background
      
      -- ========================================================================
      -- Adapter Configuration: pwa-node
      -- ========================================================================
      -- This uses Microsoft's js-debug adapter (same as VS Code uses)
      -- It supports modern JavaScript/TypeScript debugging with full source map support
      
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",  -- Dynamic port allocation
        executable = {
          command = "node",
          -- Path to js-debug-adapter installed via Mason
          -- vim.fn.stdpath("data") resolves to ~/.local/share/LazyVim
          args = {
            vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
            "${port}"
          }
        }
      }
      
      -- ========================================================================
      -- Workspace Configuration
      -- ========================================================================
      -- Define your monorepo root path
      local workspace_folder = "/Users/juri.diener/Documents/projects/hains/hains_docker/monorepo/my_workspace"
      
      -- ========================================================================
      -- Debug Configuration: TypeScript
      -- ========================================================================
      dap.configurations.typescript = {
        {
          -- Configuration name (shown in debug picker)
          name = "Attach to NestJS API (Docker)",
          
          -- Use pwa-node adapter
          type = "pwa-node",
          
          -- Attach to already running process (your Docker container)
          request = "attach",
          
          -- Connection settings
          address = "localhost",
          port = 9229,  -- Debug port exposed by Docker
          
          -- Path mapping between local files and Docker container
          localRoot = workspace_folder,  -- Your local workspace
          remoteRoot = "/app",           -- Path inside Docker container
          
          -- Working directory (important for resolving paths)
          cwd = workspace_folder,
          
          -- Source map configuration
          sourceMaps = true,
          
          -- Where to look for source maps
          resolveSourceMapLocations = {
            workspace_folder .. "/**",      -- Look in entire workspace
            "!**/node_modules/**"         -- But skip node_modules
          },
          
          -- ====================================================================
          -- Source Map Path Overrides
          -- ====================================================================
          -- Maps webpack-generated paths to actual file system paths
          -- This is crucial for breakpoints to work in your monorepo
          sourceMapPathOverrides = {
            -- IMPORTANT: Order matters! More specific patterns first.
            
            -- Webpack paths from apps/api perspective (webpack runs from apps/api/)
            -- Pattern: webpack:///./src/* maps to apps/api/src/*
            ["webpack:///./src/*"] = workspace_folder .. "/apps/api/src/*",
            ["webpack:///src/*"] = workspace_folder .. "/apps/api/src/*",
            
            -- Webpack paths for API source (less common but included for completeness)
            ["webpack:///./apps/api/src/*"] = workspace_folder .. "/apps/api/src/*",
            ["webpack:///apps/api/src/*"] = workspace_folder .. "/apps/api/src/*",
            
            -- Webpack relative paths from compiled code to libs (../../libs/...)
            -- These are the most common for your monorepo libs
            ["webpack:///../../libs/prisma_cruds/src/lib/*"] = workspace_folder .. "/libs/prisma_cruds/src/lib/*",
            ["webpack:///../../libs/models/src/lib/*"] = workspace_folder .. "/libs/models/src/lib/*",
            ["webpack:///../../libs/utils/src/lib/*"] = workspace_folder .. "/libs/utils/src/lib/*",
            ["webpack:///../../libs/*/src/lib/*"] = workspace_folder .. "/libs/*/src/lib/*",
            ["webpack:///../../libs/*"] = workspace_folder .. "/libs/*",
            
            -- Webpack paths for libraries (direct)
            ["webpack:///./libs/*"] = workspace_folder .. "/libs/*",
            ["webpack:///libs/*"] = workspace_folder .. "/libs/*",
            
            -- Additional fallback patterns
            ["../src/*"] = workspace_folder .. "/apps/api/src/*",
            ["../libs/*"] = workspace_folder .. "/libs/*",
            ["../../libs/*"] = workspace_folder .. "/libs/*",
            
            -- Root level webpack paths (least specific, should be last)
            ["webpack:///*"] = workspace_folder .. "/*",
          },
          
          -- Files to skip during debugging (don't step into these)
          skipFiles = {
            "<node_internals>/**",           -- Node.js internals
            "**/node_modules/**",            -- All dependencies
            workspace_folder .. "/node_modules/**",
            workspace_folder .. "/dist/**/*.js" -- Compiled output
          },
          
          -- Output files location (compiled JavaScript)
          outFiles = {
            workspace_folder .. "/dist/apps/api/**/*.js"
          },
          
          -- Additional configuration
          restart = true,                    -- Auto-restart on file changes
          protocol = "inspector",            -- Use inspector protocol (Chrome DevTools)
          console = "integratedTerminal",    -- Show console output in terminal
          
          -- Enable detailed logging for troubleshooting
          trace = true,
          
          -- Timeout for connecting to debugger (in milliseconds)
          timeout = 60000,  -- 60 seconds
          
          -- Environment variables (inherit from Docker)
          env = { 
            WORKSPACE_FOLDER = workspace_folder 
          },
        }
      }
      
      -- ========================================================================
      -- Debug Configuration: JavaScript
      -- ========================================================================
      -- Use the same configuration for JavaScript files
      dap.configurations.javascript = dap.configurations.typescript
      
      -- ========================================================================
      -- Debug Logging Configuration
      -- ========================================================================
      -- Enable detailed logging for troubleshooting
      dap.set_log_level("TRACE")
      vim.g.dap_log_file = "/tmp/dap.log"
      
      -- You can view the log with: tail -f /tmp/dap.log
      
      -- ========================================================================
      -- Event Listeners
      -- ========================================================================
      -- These provide feedback when debugging events occur
      
      dap.listeners.after["event_initialized"]["my_debug"] = function(session, body)
        print("✅ DAP Initialized! Debugger attached successfully.")
        print("📝 Debug log: /tmp/dap.log")
      end
      
      dap.listeners.after["event_breakpoint"]["my_debug"] = function(session, body)
        print("🔴 Breakpoint hit!")
      end
      
      dap.listeners.after["event_terminated"]["my_debug"] = function(session, body)
        print("🛑 DAP Terminated!")
      end
      
      dap.listeners.after["event_exited"]["my_debug"] = function(session, body)
        print("👋 Debug session exited.")
      end
    end,
  },
  
  -- ============================================================================
  -- DAP UI Plugin
  -- ============================================================================
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "nvim-neotest/nvim-nio" },
    lazy = false,  -- Load immediately with DAP
    
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      
      -- ========================================================================
      -- DAP UI Layout Configuration
      -- ========================================================================
      dapui.setup({
        -- Icons used in the UI
        icons = { 
          expanded = "▾", 
          collapsed = "▸", 
          current_frame = "▸" 
        },
        
        -- Mappings inside DAP UI windows
        mappings = {
          expand = { "<CR>", "<2-LeftMouse>" },  -- Expand item
          open = "o",                             -- Open item
          remove = "d",                           -- Remove item
          edit = "e",                             -- Edit item
          repl = "r",                             -- Open REPL
          toggle = "t",                           -- Toggle item
        },
        
        -- ======================================================================
        -- UI Layout
        -- ======================================================================
        layouts = {
          -- Left sidebar: Variables, Breakpoints, Call Stack, Watches
          {
            elements = {
              -- Scopes: Local variables and function arguments
              { id = "scopes", size = 0.40 },      -- 40% of sidebar height
              
              -- Breakpoints: List of all breakpoints
              { id = "breakpoints", size = 0.20 }, -- 20% of sidebar height
              
              -- Stacks: Call stack / backtrace
              { id = "stacks", size = 0.20 },      -- 20% of sidebar height
              
              -- Watches: Custom watch expressions
              { id = "watches", size = 0.20 },     -- 20% of sidebar height
            },
            size = 50,        -- 50 columns wide
            position = "left",
          },
          
          -- Bottom panel: REPL and Console
          {
            elements = {
              -- REPL: Execute code during debugging
              { id = "repl", size = 0.5 },    -- 50% of bottom panel
              
              -- Console: Application console output
              { id = "console", size = 0.5 }, -- 50% of bottom panel
            },
            size = 10,         -- 10 lines tall
            position = "bottom",
          },
        },
        
        -- Floating windows configuration
        floating = {
          max_height = nil,   -- Use default
          max_width = nil,    -- Use default
          border = "single",  -- Border style: "single", "double", "rounded", "solid", "shadow"
          mappings = {
            close = { "q", "<Esc>" },
          },
        },
        
        -- Control windows (hover widgets)
        windows = { indent = 1 },
      })
      
      -- ========================================================================
      -- Auto-open/close DAP UI
      -- ========================================================================
      -- Automatically open the UI when debugging starts
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      
      -- Automatically close the UI when debugging stops
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end
  },
  
  -- ============================================================================
  -- Virtual Text Plugin
  -- ============================================================================
  -- Shows variable values inline in your code as you debug
  {
    "theHamsta/nvim-dap-virtual-text",
    lazy = false,  -- Load immediately with DAP
    opts = {
      enabled = true,                        -- Enable virtual text
      enabled_commands = true,               -- Create commands to toggle
      highlight_changed_variables = true,    -- Highlight changed values
      highlight_new_as_changed = false,      -- Don't highlight new variables as changed
      show_stop_reason = true,               -- Show why execution stopped
      commented = false,                     -- Don't comment out virtual text
      only_first_definition = true,          -- Only show for first occurrence
      all_references = false,                -- Don't show for all references
      
      -- Position of virtual text
      -- Options: 'eol' (end of line), 'overlay', 'inline'
      virt_text_pos = 'eol',
      
      -- Format of virtual text
      -- Shows as: variable_name = value
      all_frames = false,  -- Only show for current frame
      virt_lines = false,  -- Don't use virtual lines
      virt_text_win_col = nil,  -- Use default column
    }
  },
}
