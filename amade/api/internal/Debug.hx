package amade.api.internal;

import lua.Table;
import haxe.Constraints.Function;
import lua.Thread;
import haxe.extern.EitherType;

@:native("debug")
extern class Debug {
    extern static function setfenv(func: EitherType<Thread, Function>, env: Table<Any, Any>): Function;
}