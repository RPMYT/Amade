package amade.api.internal.process;

import amade.api.internal.process.Scheduler;
import lua.Thread;
import lua.Coroutine;
import haxe.Constraints.Function;
import amade.api.internal.multiuser.User;
import amade.api.internal.multiuser.UserManager;
import amade.util.Error;

class ProcessInfo {
    public final id: Int;
    public final process: Thread;
    private var priority: Int = 0;

    public function new(id: Int, func: Function) {
        this.id = id;
        this.process = Coroutine.create(func);
    }

    public function setPriority(priority: Int): Null<Error> {
        if (priority < -20 || priority > 20) {
            return Error.EINVAL("Cannot have priorities below -20 or above 20");
        }

        if (priority < this.priority && (UserManager.getCurrentUser() != User.RootUser) || Scheduler.getCurrentProcess().id != 1) {
            return Error.EPERM("Only root or the scheduler can raise a process's priority");
        }

        if (priority == this.priority) {
            return Error.EINVAL("Cannot set a process's priority to it's current value");
        }

        this.priority = priority;
        return null;
    }
}