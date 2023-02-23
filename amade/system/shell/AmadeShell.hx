package amade.system.shell;

import amade.api.AmadeError;
import lua.Table;
import amade.system.boot.AmadeSystemFSLV._G;
import lua.NativeStringTools;
import lua.Lua;
import lua.PairTools;
import cc.FileSystem;
import cc.IO;

class AmadeShell {
    public var SearchPaths: Table<Int, String> = Table.create();
    public var BuiltinCMDs: Table<Int, String> = Table.create();

    public var CurrentWorkingDirectory: String;
    public var ShellRunning: Bool = false;

    public function new(?paths: Array<String>) {
        SearchPaths[1] = "/Library/Programs/?.apb";
        SearchPaths[2] = "?.lua";
        if (paths.length >= 1) {
            var index = 2;
            for (path in paths) {
                SearchPaths[index] = path;
                index++;
            }
        }
        
        BuiltinCMDs[1] = "cd";
        BuiltinCMDs[2] = "exit";
        BuiltinCMDs[3] = "ls";
    }

    public function execute(command: String, ?params: Array<String>, ?cwd: String): Table<String, Any> {
        var result: Table<String, Any> = Table.create();

        var success = false;
        var error: String = AmadeError.EUNKNOWN.getName();
        var output: Table<Int, String> = Table.create();

        // TODO: home directories
        if (cwd != null && cwd != "") {
            this.CurrentWorkingDirectory = cwd;
        }

        var found = false;

        PairTools.pairsEach(FileSystem.list(this.CurrentWorkingDirectory), (index, path) -> {
            if (path == command) {
                found = true;
                var handle = IO.open(this.CurrentWorkingDirectory + path);
                var source = "";

                if (handle != null) {
                    source = handle.read("*a");
                }

                var result = _G.load(source, this.CurrentWorkingDirectory + path);
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
                    success = false;
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

        if (success) {
            result.output = output;
        } else {
            result.error = error;
            result.output = Table.create();
        }

        return result;
    }

    public static function run() {
        var shell = new AmadeShell();
        do {
            // TODO: more verbose prompt
            IO.write("> ");
            var command = IO.read();

            // Examples:
            // `Amade Editor: Main.lua`
            // `Amade Packager: MyProgram/Main.lua, MyProgram/icon.img`
            // `Amade Packager: MyProgram/src/ as ProgramSource, MyProgram/resources/default.cfg as MyProgramDefaultConfig`
            var params = NativeStringTools.gsub(command, ".*:%s", "").split(", ");
            command = NativeStringTools.gsub(command, ":%s.*", "");

            if(params.length == 1 && params[0] == command) {
                params.remove(command);
            }

            var options: Table<String, String> = Table.create();
            for (parameter in params) {
                if (StringTools.contains(parameter, " as ")) {
                    var option = NativeStringTools.gsub(parameter, "%sas%s.*", "");
                    var value = NativeStringTools.gsub(parameter, ".*%sas%s", "");

                    Lua.rawset(options, option, value);
                    params.remove(parameter);
                }
            }

            if (params[0] == command) {
                params.remove(command);
            }

            if (Table.toArray(shell.BuiltinCMDs).contains(command)) {
                switch (command) {
                    case "cd": {
                        if (params.length >= 1) {
                            if (params[0] == "") {
                                // TODO: home directories
                            }
    
                            // TODO: relative paths
                            // TODO: check if path actually exists
                            shell.CurrentWorkingDirectory = params[0];
                        }
                    }
    
                    case "exit": {
                        shell.ShellRunning = false;
                    }
    
                    case "ls": {
                        var directory = shell.CurrentWorkingDirectory;
                        if (params.length >= 1) {
                            directory = params[0];
                        }
                        var list = "";
                        PairTools.pairsEach(FileSystem.list(shell.CurrentWorkingDirectory + directory), (index, path) -> {
                            list = list + path + " ";
                        });
                        IO.write(list + "\n");
                    }
                }
            } else {
                var result = shell.execute(command, params);

                if (result.success == false) {
                    IO.stderr.write("Command not found: " + command + "\n");
                }
            }
        } while (shell.ShellRunning);
    }
}