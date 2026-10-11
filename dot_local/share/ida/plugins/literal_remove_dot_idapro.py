from pathlib import Path

import ida_idaapi


class MyPlugin(ida_idaapi.plugin_t):
	flags = ida_idaapi.PLUGIN_UNL | ida_idaapi.PLUGIN_MULTI | ida_idaapi.PLUGIN_FIX
	wanted_name = "Remove ~/.idapro"

	def init(self):
		print(">>>Remove ~/.idapro: called.")
		(Path.home() / ".idapro").rmdir()
		return ida_idaapi.plugmod_t()


def PLUGIN_ENTRY():
	return MyPlugin()
