package amade.api;

import amade.api.Command;
import amade.api.internal.API;
import haxe.extern.EitherType;
import amade.util.Error;
import lua.Table;

class Shell extends API {
    private var SearchPaths: Table<Int, String> = Table.create();
    private var BuiltinCMDs: Table<Int, String> = Table.create();

    var CurrentWorkingDirectory: String = "/";
    var ShellRunning: Bool = true;

    public function new(?directory: String, ?paths: Array<String>) {
        SearchPaths[1] = "/Library/Programs/?.apb";
        SearchPaths[2] = "/Library/Programs/?.lua";
        SearchPaths[3] = "?.apb";
        SearchPaths[4] = "?.lua";
        
        if (directory != null) {
            this.CurrentWorkingDirectory = directory;
        }

        if (paths != null && paths.length >= 1) {
            var index = 2;
            for (path in paths) {
                SearchPaths[index] = path;
                index++;
            }
        }
        
        BuiltinCMDs[1] = "cd";
        BuiltinCMDs[2] = "exit";
    }

    public function autocomplete(partial: String): List<String> {
        var possible = new List();

        return possible;
    }

    public function execute(command: EitherType<Command, String>, ?params: Array<String>, ?cwd: String): EitherType<Error, Table<Any, Any>> {
        var result: Table<Any, Any> = Table.create();

        var success = false;
        var output: Table<Int, String> = Table.create();

        // TODO: home directories
        if (cwd != null && cwd != "") {
            this.CurrentWorkingDirectory = cwd;
        }

        if (this.CurrentWorkingDirectory == null) {
            this.CurrentWorkingDirectory = "/";
        }

        var found = false;

        if (Std.isOfType(command, Command)) {
            var command = Std.downcast(command, Command);
            result = command.execute(params);
        }

        if (!found) {
            return Error.ENOENT(command);
        }

        return result;
    }
}