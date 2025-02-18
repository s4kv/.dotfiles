return {
        "folke/noice.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        opts = {
            lsp = {
                progress = {
                    enabled = true, -- Enable LSP progress notifications
                },
            },
            notify = {
                enabled = true,
                timeout = 3000, -- Notification timeout in milliseconds
            },
            messages = {
                enabled = true,
                view = "mini", -- Use a small popup for messages
            },
            presets = {
                lsp_doc_border = true, -- Enable borders for LSP docs
            },
        },
}
