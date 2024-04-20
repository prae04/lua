local bufnr = 5--, {"/bin/bash", "-c", "ls", "-l"}
--vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "Hello", "World!" })

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	group = vim.api.nvim_create_augroup("AutoBashExec", { clear = true }),
	pattern = "test.sh",
	callback = function()
		local append_data = function(_, data)
			if data then
				vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, data)
			end
		end
		vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "Output of test.sh:"})
		vim.fn.jobstart("bash -c 'source test.sh'", {
			stdout_buffered = true ,
			on_stdout = append_data,
			on_stderr = append_data,
		})
	end
})
