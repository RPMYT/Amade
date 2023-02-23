package amade.system.shell;

import lua.Table;
import amade.system.boot.AmadeSystemFSLV._G;
import lua.NativeStringTools;
import lua.Lua;
import lua.PairTools;
import cc.FileSystem;
import cc.IO;

class AmadeShell {
    public static var SearchPaths: Table<Int, String> = Table.create();
    public static var BuiltinCMDs: Table<Int, String> = Table.create();

    public static function run() {
        if (Table.toArray(SearchPaths).length == 0) {
            SearchPaths[1] = "/Library/Programs/?.apb";
        }

        if (Table.toArray(BuiltinCMDs).length == 0) {
            BuiltinCMDs[1] = "cd";
            BuiltinCMDs[2] = "exit";
            BuiltinCMDs[3] = "ls";
        }

        // TODO: home directories
        var currentDir = "/";
        var running = true;

        do {
            // TODO: more verbose prompt
            IO.write("> ");
            var command = IO.read();

            // Examples:
            // `Amade Editor: Main.lua`
            // `Amade Packager: MyProgram/Main.lua, MyProgram/icon.img`
            // `Amade Packager: MyProgram/src/ is ProgramSource, MyProgram/resources/default.cfg is MyProgramDefaultConfig`
            var params = NativeStringTools.gsub(command, ".*:%s", "").split(", ");
            command = NativeStringTools.gsub(command, ":%s.*", "");

            if(params.length == 1 && params[0] == command) {
                params.remove(command);
            }

            var options: Table<String, String> = Table.create();
            for (parameter in params) {
                if (StringTools.contains(parameter, " as ")) {
                    var option = NativeStringTools.gsub(parameter, "%sis%s.*", "");
                    var value = NativeStringTools.gsub(parameter, ".*%sis%s", "");

                    Lua.rawset(options, option, value);
                    params.remove(parameter);
                }
            }

            // TOOD: handle more special commands
            if (Table.toArray(BuiltinCMDs).contains(command)) {
                Sys.println(params.length);
                switch (command) {
                    case "cd": {
                        if (params.length >= 0) {
                            if (params[1] == "") {
                                // TODO: home directories
                                continue;
                            }
                            currentDir = params[0];
                            continue;
                        }
                    }

                    case "exit": {
                        running = false;
                        break;
                    }

                    case "ls": {
                        var directory = currentDir;
                        if (params.length >= 1) {
                            directory = params[0];
                        }
                        var list = "";
                        PairTools.pairsEach(FileSystem.list(currentDir + directory), (index, path) -> {
                            list = list + path + " ";
                        });
                        IO.write(list + "\n");
                        continue;
                    }
                }
            }

            var found = false;
            PairTools.pairsEach(FileSystem.list(currentDir), (index, path) -> {
                if (path == command) {
                    found = true;
                    var handle = IO.open(currentDir + path);
                    var source = "";

                    if (handle != null) {
                        source = handle.read("*a");
                    }

                    var result = _G.load(source, currentDir + path);
                    if (result.func != null) {
                        var func = Lua.load(source).func;
                        var result = Lua.pcall(func);

                        if (result.status == false) {
                            Lua.print(result.value);
                        }
                    } else {
                        IO.stderr.write(result.message + "\n");
                    }
                }
            });

            if (!found) {
                if (FileSystem.exists(command)) {
                    found = true;
                    var handle = IO.open(command);
                    var source = "";

                    if (handle != null) {
                        source = handle.read("*a");
                    }

                    var result = _G.load(source, command);
                    if (result.func != null) {
                        var func = Lua.load(source).func;
                        
                        var returned = Lua.pcall(func);
                        if (returned.status == false) {
                            IO.stderr.write(NativeStringTools.gsub(NativeStringTools.gsub(returned.value, "string [\"", ""), "]\"", "") + "\n");
                        }
                    } else {
                        IO.stderr.write(result.message + "\n");
                    }
                }
            }

            if (!found) {
                PairTools.pairsEach(SearchPaths, (index, path) -> {
                    if (FileSystem.exists(NativeStringTools.gsub(path, "?", command))) {
                        var app = NativeStringTools.gsub(path, "?", command);
                        
                        var handle = IO.open(app);
                        var source = "";
                    }
                });
            }

            if (!found) {
                IO.stderr.write("Command not found: " + command + "\n");
            }
        } while (running);
    }
}