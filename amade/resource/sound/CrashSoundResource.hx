package amade.resource.sound;

import lua.NativeStringTools;
import amade.resource.system.SystemFileResource;

class CrashSoundResource {
    private static final resource: String = NativeStringTools.sub(SystemFileResource.get(), NativeStringTools.find(SystemFileResource.get(), "//SND_CRASH_BEGIN\n.").end, NativeStringTools.find(SystemFileResource.get(), ".\n//SND_CRASH_END").begin).match;

    public static function get(): String {
        return resource;
    }
}