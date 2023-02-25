package amade.system.boot;

import amade.api.audio.DFPWM;
import cc.Peripheral;
import cc.FileSystem;
import cc.IO;
import lua.NativeStringTools;
import haxe.Constraints.Function;
import lua.Lua;
import lua.Table;
import cc.ComputerCraft;
import cc.OS;

@:native("_G")
extern class _G {
	public static var _OSVERSION: String;
	public static var _HOST: String;
	public static var raw: Table<String, Function>;
	public static var utf8: Table<String, Function>;
	public static var require: Function;
	public static function load(data: String, source: String): LoadResult;
	public static var _ENV: Table<String, Any>;
}

@:native("package")
extern class CobaltPackage {
	public static var preload: Table<String, Function>;
}

class AmadeSystemFSLV {
	public static function main() {
		_G.raw = Table.create();

		Lua.rawset(_G.raw, "printError", Lua.load(NativeStringTools.dump(ComputerCraft.printError)).func);
		Lua.rawset(_G.raw, "os.run", Lua.load(NativeStringTools.dump(OS.run)).func);

		OS.run = null;

		OS.version = function version() {
			return _G._OSVERSION;
		}

		ComputerCraft.printError = function(message: String) {
			Sys.println("--- LOADING THE AMADE OPERATING SYSTEM ---");

			if (FileSystem.exists("/Amade/System/init.lua")) {
				var handle = FileSystem.open("/Amade/System/init.lua", "r");
				var source = "";

				if (handle != null) {
					source = handle.readAll();
				}

				var result = _G.load(source, "/Amade/System/init.lua");
				if (result.func != null) {
					var func = _G.load(source, "/Amade/System/init.lua").func;
					
					var result = Lua.pcall(func);
					if (result.status == false) {
						Lua.print(result.value);
					}
				} else {
					// if (Peripheral.find("speaker")) {
					// 	var speaker = Peripheral.find("speaker");

					// 	var decoder = DFPWM.make_decoder();
					// 	speaker.playAudio(decoder(AmadeResourceData.Sounds.System.Crash.data.match));
					// }

					IO.stderr.write("Failed to load Amade :(");
					IO.stderr.write("Reason: " + result.message);

					IO.write("\n\nPress any key to continue.");
					OS.pullEvent("key");
					OS.shutdown();
				}
			}

			// No VSCode, the package should not be `system.boot`
			AmadeSystemSSLV.RunSecondStage();
		}

		// we need a way to crash the BIOS automatically on CraftOS-PC
		if (!StringTools.contains(_G._HOST, "CraftOS-")) {
			Sys.println("Not running on CraftOS-PC, crashing Lua VM automatically via OOM.");
			NativeStringTools.rep("AMADE FSLV", 2^31-1);
		}
	}
}