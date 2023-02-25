package amade.api.internal.process;

import amade.api.internal.process.Environmentalizer;
import amade.api.internal.Debug;
import lua.Lua;
import amade.util.Error;
import haxe.Constraints.Function;
import amade.api.internal.filesystem.IOMode;
import haxe.extern.EitherType;
import amade.api.internal.filesystem.FileHandle;
import amade.api.Filesystem;
import amade.util.Pair;

class Loader {
    public static function loadfile(path: String): EitherType<Error, Function> {
        var handle = Filesystem.open(path, IOMode.READ, false);

        if (handle is Error) {
            return handle;
        } else {
            var handle = Std.downcast(handle, FileHandle);

            var data = handle.read();
            if (data is Error) {
                return data;
            } else {
                var data = Std.downcast(data, Pair);
                var result = Lua.load(data.left);
                if (result.func != null) {
                    var func = Lua.load(data.left).func;
                    return Debug.setfenv(func, Environmentalizer.environmentalize());
                } else {
                    return Error.EINVAL(result.message);
                }
            }
        }
    }
}