local M = {}

local loaded = {}
local packadded = {}

local pack_dir = vim.fn.stdpath("data") .. "/site/pack/core/opt/"

local function packadd(name)
	if not packadded[name] then
		packadded[name] = true
		vim.cmd.packadd(name)
	end
end

local function load_entry(entry)
	local load_key = entry.fn and (entry.mod .. "." .. entry.fn) or entry.mod
	if loaded[load_key] then
		return
	end
	loaded[load_key] = true

	if entry.packadd then
		for _, name in ipairs(entry.packadd) do
			packadd(name)
		end
	end

	local ok, mod = pcall(require, "plugins." .. entry.mod)
	if not ok then
		vim.notify("[pack] " .. entry.mod .. ": " .. tostring(mod), vim.log.levels.ERROR)
		return
	end

	if entry.fn then
		if type(mod[entry.fn]) == "function" then
			local fn_ok, err = pcall(mod[entry.fn])
			if not fn_ok then
				vim.notify("[pack] " .. entry.mod .. "." .. entry.fn .. "(): " .. tostring(err), vim.log.levels.ERROR)
			end
		else
			vim.notify("[pack] " .. entry.mod .. " has no function " .. entry.fn, vim.log.levels.ERROR)
		end
	end
end

function M.setup(registry)
	for _, entry in ipairs(registry) do
		if entry.event then
			local events = type(entry.event) == "table" and entry.event or { entry.event }
			local group_name = "pack-" .. entry.mod .. (entry.fn and ("-" .. entry.fn) or "")
			local group = vim.api.nvim_create_augroup(group_name, { clear = true })
			vim.api.nvim_create_autocmd(events, {
				group = group,
				pattern = entry.pattern,
				once = entry.once ~= false,
				callback = function()
					load_entry(entry)
				end,
			})
		elseif entry.keys then
			for _, k in ipairs(entry.keys) do
				local key = k[1]
				local desc = k.desc or ("Load " .. entry.mod)
				local mode = k.mode or "n"
				vim.keymap.set(mode, key, function()
					pcall(vim.keymap.del, mode, key)
					load_entry(entry)
					local keys = vim.api.nvim_replace_termcodes(key, true, false, true)
					vim.api.nvim_feedkeys(keys, "mit", false)
				end, { desc = desc, nowait = true })
			end
		elseif entry.defer then
			vim.defer_fn(function()
				load_entry(entry)
			end, entry.defer)
		else
			load_entry(entry)
		end
	end
end

function M.loaded()
	return vim.tbl_keys(loaded)
end

function M.update()
	local buf = vim.api.nvim_create_buf(false, true)
	local width = math.floor(vim.o.columns * 0.65)
	local height = math.floor(vim.o.lines * 0.65)

	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		col = math.floor((vim.o.columns - width) / 2),
		row = math.floor((vim.o.lines - height) / 2),
		style = "minimal",
		border = "single",
		title = "󰏕 Package Updater ",
		title_pos = "center",
	})

	vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "Searching for updates...", "" })

	local handle = vim.uv.fs_scandir(pack_dir)
	if not handle then
		vim.api.nvim_buf_set_lines(buf, -1, -1, false, { "❌ Directory tracking failed: " .. pack_dir })
		return
	end

	local plugins = {}
	while true do
		local name, fs_type = vim.uv.fs_scandir_next(handle)
		if not name then
			break
		end
		if fs_type == "directory" then
			table.insert(plugins, name)
		end
	end

	if #plugins == 0 then
		vim.api.nvim_buf_set_lines(buf, -1, -1, false, { "Zero plugins detected in package folder targets." })
		return
	end

	local completed = 0
	for _, plugin in ipairs(plugins) do
		local path = pack_dir .. plugin

		vim.fn.jobstart({
			"sh",
			"-c",
			"git fetch origin --tags -q && "
				.. "BRANCH=$(git branch -r | grep -oE 'origin/(main|master|trunk)$' | head -n1 | sed 's|origin/||') && "
				.. '[ -n "$BRANCH" ] && git reset --hard "origin/$BRANCH"',
		}, {
			cwd = path,
			stdout_buffered = true,
			on_stdout = function(_, data)
				if data and #data > 0 then
					local lines = {}
					for _, line in ipairs(data) do
						if line ~= "" and not line:match("HEAD is now at") then
							table.insert(lines, "  " .. line)
						end
					end
					if #lines > 0 then
						table.insert(lines, 1, " [" .. plugin .. "]:")
						vim.api.nvim_buf_set_lines(buf, -1, -1, false, lines)
					end
				end
			end,
			on_stderr = function(_, data)
				if data and #data > 0 then
					local errors = {}
					for _, line in ipairs(data) do
						if
							line ~= ""
							and not line:match("From ")
							and not line:match("%* branch")
							and not line:match("Fetching")
						then
							table.insert(errors, "⚠️ [" .. plugin .. "]: " .. line)
						end
					end
					if #errors > 0 then
						vim.api.nvim_buf_set_lines(buf, -1, -1, false, errors)
					end
				end
			end,
			on_exit = function(_, exit_code)
				completed = completed + 1
				if completed == #plugins then
					vim.api.nvim_buf_set_lines(buf, -1, -1, false, { "", "󱝍  Neovim is up to date." })
				end
			end,
		})
	end
	vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = buf, silent = true })
end

return M
