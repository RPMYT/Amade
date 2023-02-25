package amade.api;

import amade.api.internal.process.Scheduler;
import amade.util.Error;
import haxe.extern.EitherType;
import amade.api.internal.process.ProcessInfo;
import amade.api.internal.API;

class Process extends API {
    public static function getInfo(?id: Int): EitherType<Error, ProcessInfo> {
        if (id == null) {
            return Scheduler.getCurrentProcess();
        } else {
            return Scheduler.getSpecificProcess(id);
        }
    }
}