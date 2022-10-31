local kind_icons = {
	Text = "",
	Method = "m",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "",
	Interface = "",
	Module = "",
	Property = "",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
}

vim.g.coq_settings = {
	auto_start = "shut-up",
	display = {
		["ghost_text.context"] = { "  ❬ ", " ❭ " },
		pum = {
			kind_context = { "(", ")" },
			source_context = { "⌈ ", " ⌋" },
		},
		icons = {
			mappings = kind_icons,
			-- aliases = kind_aliases,
		},
	},
	keymap = {
		jump_to_mark = "<c-b>",
		["repeat"] = "^.",
	},
}
