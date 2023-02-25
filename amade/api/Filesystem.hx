package amade.api;

import amade.api.internal.API;
import amade.api.internal.filesystem.IOMode;
import amade.util.Error;
import haxe.extern.EitherType;
import cc.FileSystem;

class Filesystem extends API {
    public static function exists(path: String): Bool {
        return FileSystem.exists("/Amade/" + path);
    }

    public static function open(path: String, mode: IOMode, binary: Bool): EitherType<Error, amade.api.internal.filesystem.FileHandle> {
        if (!exists(path)) {
            return Error.ENOENT(path);
        } else {
            return new amade.api.internal.filesystem.FileHandle("/Amade/" + path, mode, binary);
        }
    }
    
    public static function modes(): Enum<IOMode> {
        return IOMode;
    }
}