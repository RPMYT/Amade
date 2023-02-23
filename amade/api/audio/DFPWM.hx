package amade.api.audio;

import haxe.Constraints.Function;

@:luaDotMethod
@:native("cc.audio.dfpwm")
extern class DFPWM {
    public static function make_decoder():Function;
}
