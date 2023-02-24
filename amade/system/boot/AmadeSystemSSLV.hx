package amade.system.boot;

import amade.api.filesystem.FileHandle.Mode;
import amade.api.filesystem.AmadeFilesystem;
import amade.system.boot.AmadeSystemFSLV.CobaltPackage;
import cc.Term;
import cc.ComputerCraft;
import lua.Lua;
import cc.OS;
import amade.api.audio.DFPWM;
import amade.data.AmadeResourceData;
import cc.Peripheral;
import cc.IO;
import amade.system.shell.AmadeShell;

class AmadeSystemSSLV {
    public static function RunSecondStage() {
        Lua.print("Loading " + OS.version() + "...");

        IO.write("\nUnreplacing `printError`... ");
        ComputerCraft.printError = message -> {
            IO.stderr.write(message + "\n");
        }
        IO.write("done\n");

        IO.write("Adding APIs to `require`... ");
        var pos = Term.getCursorPos();

        IO.write("\n`shell`... ");
        Lua.rawset(CobaltPackage.preload, "shell", () -> {
            return AmadeShell;
        });
        IO.write("done\n");

        IO.write("`filesystem`... ");
        Lua.rawset(CobaltPackage.preload, "filesystem", () -> {
            return AmadeFilesystem;
        });
        Lua.rawset(CobaltPackage.preload, "filesystem.modes", () -> {
            return Mode;
        });
        IO.write("done\n");

        var here = Term.getCursorPos();
        Term.setCursorPos(pos.x, pos.y);
        IO.write("done");
        Term.setCursorPos(here.x, here.y);

        Sys.println("TODO: improve shell [Lilirine]");
        Sys.println("TODO: device files [Lilirine]");
        Sys.println("TODO: replace `io` and `fs` [Lilirine]");
        Sys.println("TODO: multiple processes at once [graypinkfurball]");
        Sys.println("TODO: multiuser [graypinkfurball]");

        if (Peripheral.find("speaker")) {
            var speaker = Peripheral.find("speaker");

            var decoder = DFPWM.make_decoder();
            speaker.playAudio(decoder(AmadeResourceData.Sounds.System.StartupComplete.data.match));
        }

        AmadeShell.run();
        
        if (Peripheral.find("speaker")) {
            var speaker = Peripheral.find("speaker");

            var decoder = DFPWM.make_decoder();
            speaker.playAudio(decoder(AmadeResourceData.Sounds.System.Crash.data.match));
        }

        IO.stderr.write("Amade crashed :(");

        IO.write("\n\nPress any key to continue.");
        OS.pullEvent("key");
        OS.shutdown();
    }
}