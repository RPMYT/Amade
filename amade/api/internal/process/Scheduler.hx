package amade.api.internal.process;

import haxe.Int32;
import amade.util.Error;
import haxe.extern.EitherType;
import lua.Table;
import haxe.Constraints.Function;
import amade.api.internal.process.ProcessInfo;

class Scheduler {
    private static var ProcessList: Table<Int, ProcessInfo> = Table.create();
    private static var LastPID = 1;
    private static var CurrentPID = 1;

    public static function scheduleNewProcess(func: Function, ?priority: Int): EitherType<Error, ProcessInfo> {
        var info = new ProcessInfo(++LastPID, func);
        if (priority != null && priority != 0) {
            if (priority > 20) {
                priority = 20;
            }

            if (priority < -20) {
                priority = -20;
            }
            
            var err = info.setPriority(priority);
            if (err != null) {
                return err;
            }
        }
        ProcessList[LastPID] = info;
        CurrentPID = LastPID;

        return info;
    }

    public static function getCurrentProcess(): ProcessInfo {
        return ProcessList[CurrentPID];
    }

    public static function getSpecificProcess(id: Int): EitherType<Error, ProcessInfo> {
        if (ProcessList[id] != null) {
            return ProcessList[id];
        }

        return Error.ESRCH("PID " + id + " does not exist");
    }
}