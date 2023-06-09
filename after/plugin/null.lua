local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
	-- you can reuse a shared lspconfig on_attach callback here
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.diagnostics.eslint,
		null_ls.builtins.completion.spell,
		null_ls.builtins.formatting.rustfmt,
		null_ls.builtins.formatting.rustfmt,
		null_ls.builtins.diagnostics.eslint_d,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.diagnostics.eslint,
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
		end
	end,
})
