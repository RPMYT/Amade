package amade.resource.sound;

import lua.NativeStringTools;
import amade.resource.system.SystemFileResource;

class StartupSoundResource {
    private static final resource: String = NativeStringTools.sub(SystemFileResource.get(), NativeStringTools.find(SystemFileResource.get(), "//SND_STARTUP_BEGIN\n.").end, NativeStringTools.find(SystemFileResource.get(), ".\n//SND_STARTUP_END").begin).match;

    public static function get(): String {
        return resource;
    }
}