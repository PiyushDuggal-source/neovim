local present, notify = pcall(require, "notify")

if not present then
	return
end

local options = {}

notify.setup(options)
