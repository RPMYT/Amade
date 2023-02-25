package amade.resource.system;

import amade.util.Pair;
import amade.api.internal.filesystem.FileHandle;
import amade.api.internal.filesystem.IOMode;
import amade.api.Filesystem;

class SystemFileResource {
    static final resource: String = (cast (cast Filesystem.open("Amade.lua", IOMode.READ, false) : FileHandle).read() : Pair<String, Int>).left;

    public static function get(): String {
        return resource;
    }
}