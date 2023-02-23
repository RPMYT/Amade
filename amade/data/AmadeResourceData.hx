package amade.data;

import lua.NativeStringTools;
import cc.IO;

class AmadeResourceData {
    public static var System = {
        SystemFile: {
            handle: IO.open("/Amade/Amade.lua"),
            data: AmadeResourceData.System.SystemFile.handle.read("*a")
        }
    }

    public static var Sounds = {
        System: {
            Crash: {
                name: "SND_CRASH",
                data: NativeStringTools.sub(AmadeResourceData.System.SystemFile.data, NativeStringTools.find(AmadeResourceData.System.SystemFile.data, "//SND_CRASH_BEGIN\n.").end, NativeStringTools.find(AmadeResourceData.System.SystemFile.data, ".\n//SND_CRASH_END").begin)
            },

            StartupComplete: {
                name: "SND_STARTUP",
                data: NativeStringTools.sub(AmadeResourceData.System.SystemFile.data, NativeStringTools.find(AmadeResourceData.System.SystemFile.data, "//SND_STARTUP_BEGIN\n.").end, NativeStringTools.find(AmadeResourceData.System.SystemFile.data, ".\n//SND_STARTUP_END").begin)
            }
        }
    }
}