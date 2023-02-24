package amade.api.filesystem;

import amade.api.filesystem.FileHandle.Mode;
import amade.api.Error;
import haxe.extern.EitherType;
import cc.FileSystem;

class AmadeFilesystem {
    public static function exists(path: String): Bool {
        return FileSystem.exists("/Amade" + path);
    }

    public static function open(path: String, mode: Mode, binary: Bool): EitherType<Error, amade.api.filesystem.FileHandle> {
        if (!exists(path)) {
            return Error.ENOENT;
        } else {
            return new amade.api.filesystem.FileHandle("/Amade" + path, mode, binary);
        }
    }
}