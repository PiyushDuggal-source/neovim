M = {}
local merge_tb = vim.tbl_deep_extend
M.load_config = function()
	local config = require("core.default_config")
	local chadrc_exists, chadrc = pcall(require, "custom.chadrc")

	if chadrc_exists then
		-- merge user config if it exists and is a table; otherwise display an error
		if type(chadrc) == "table" then
			config.mappings = M.remove_disabled_keys(chadrc.mappings, config.mappings)
			config = merge_tb("force", config, chadrc) or {}
		else
			error("chadrc must return a table!")
		end
	end

	config.mappings.disabled = nil
	return config
end

M.load_mappings = function(section, mapping_opt)
	local function set_section_map(section_values)
		if section_values.plugin then
			return
		end
		section_values.plugin = nil

		for mode, mode_values in pairs(section_values) do
			local default_opts = merge_tb("force", { mode = mode }, mapping_opt or {})
			for keybind, mapping_info in pairs(mode_values) do
				-- merge default + user opts
				local opts = merge_tb("force", default_opts, mapping_info.opts or {})

				mapping_info.opts, opts.mode = nil, nil
				opts.desc = mapping_info[2]

				vim.keymap.set(mode, keybind, mapping_info[1], opts)
			end
		end
	end

	local mappings = require("core.utils").load_config().mappings

	if type(section) == "string" then
		mappings[section]["plugin"] = nil
		mappings = { mappings[section] }
	end

	for _, sect in pairs(mappings) do
		set_section_map(sect)
	end
end

-- override plugin options table with custom ones
M.load_override = function(options_table, name)
	local plugin_configs, plugin_options = M.load_config().plugins, nil

	-- support old plugin syntax for override
	local user_override = plugin_configs.override and plugin_configs.override[name]
	if user_override and type(user_override) == "table" then
		plugin_options = user_override
	end

	-- if no old style plugin override is found, then use the new syntax
	if not plugin_options and plugin_configs[name] then
		local override_options = plugin_configs[name].override_options or {}
		if type(override_options) == "table" then
			plugin_options = override_options
		elseif type(override_options) == "function" then
			plugin_options = override_options()
		end
	end

	-- make sure the plugin options are a table
	plugin_options = type(plugin_options) == "table" and plugin_options or {}

	return merge_tb("force", options_table, plugin_options)
end
