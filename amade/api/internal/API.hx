package amade.api.internal;

import lua.Lua;
import amade.system.boot.AmadeSystemFSLV.CobaltPackage;

class API {
    public static function initialize() {
        CompileTime.importPackage("amade.api");

        var list = CompileTime.getAllClasses("amade.api", API);
        for (type in list) {
            Lua.rawset(CobaltPackage.preload, Type.getClassName(type).toLowerCase(), () -> {
                return type; 
            });
        }
    }
}