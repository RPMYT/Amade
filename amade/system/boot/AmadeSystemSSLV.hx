package amade.system.boot;

import amade.util.Error;
import haxe.Constraints.Function;
import amade.api.internal.process.Loader;
import amade.system.boot.AmadeSystemFSLV.CobaltPackage;
import cc.Term;
import cc.ComputerCraft;
import lua.Lua;
import cc.OS;
import cc.Peripheral;
import cc.IO;

class AmadeSystemSSLV {
    public static function RunSecondStage() {
        Lua.print("Loading " + OS.version() + "...");

        IO.write("\nUnreplacing `printError`... ");
        ComputerCraft.printError = message -> {
            if (StringTools.contains(message, "bios.lua")) {
                // if (Peripheral.find("speaker")) {
                //     var speaker = Peripheral.find("speaker");

                //     var decoder = DFPWM.make_decoder();
                //     speaker.playAudio(decoder(Resources.Sounds.System.Crash.data.match));
                // }
                IO.stderr.write("Amade crashed :(\n");
            } else {
                IO.stderr.write(message + "\n");
            }
        }
        IO.write("done\n");

        Sys.println("TODO: improve shell [Lilirine]");
        Sys.println("TODO: device files [Lilirine]");
        Sys.println("TODO: replace `io` and `fs` [Lilirine]");
        Sys.println("TODO: multiple processes at once [graypinkfurball]");
        Sys.println("TODO: multiuser [graypinkfurball]");

        // if (Peripheral.find("speaker")) {
        //     var speaker = Peripheral.find("speaker");

        //     var decoder = DFPWM.make_decoder();
        //     speaker.playAudio(decoder(AmadeResourceData.Sounds.System.StartupComplete.data.match));
        // }

        Term.clear();
        Term.setCursorPos(1, 1);

        // TODO: start init

        // NOTE: this is just for testing
        var func = Loader.loadfile("test.lua");
        if (!(func is Error)) {
            var func = (cast func : Function);
            func();
        } else {
            Sys.println((cast func : Error));
        }
    }
}