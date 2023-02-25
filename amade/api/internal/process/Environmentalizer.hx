package amade.api.internal.process;

import lua.Lua;
import lua.Table;

class Environmentalizer {

    public static function environmentalize(): Table<Any, Any> {
        var env = Table.create();

        env.print = Lua.print;

        var metatable = Table.create();
        
        Lua.setmetatable(env, metatable);

        return env;
    }
}