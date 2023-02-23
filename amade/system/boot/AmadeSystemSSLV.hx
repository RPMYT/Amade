package amade.system.boot;

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
        Lua.print("Loading Amade...");

        IO.write("\nUnreplacing `printError`... ");
        ComputerCraft.printError = message -> {
            IO.stderr.write(message + "\n");
        }
        IO.write("done\n");

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