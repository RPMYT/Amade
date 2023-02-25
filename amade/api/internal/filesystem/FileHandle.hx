package amade.api.internal.filesystem;

import amade.api.internal.filesystem.IOMode;
import amade.util.Pair;
import amade.api.internal.filesystem.FilePermission.Scope;
import amade.api.internal.multiuser.UserManager;
import amade.api.internal.filesystem.FilePermission.Permission;
import amade.api.internal.filesystem.FilePermission.PermissionUtil;
import amade.util.Error;
import haxe.extern.EitherType;
import cc.IO;
import cc.IO.OpenFileMode;
import cc.IO.LLFileHandle;

class FileHandle {
    private final readHandle: LLFileHandle;
    private final writeHandle: LLFileHandle;
    public final mode: IOMode;
    public final isBinary: Bool;

    public final err: Error;

    public function new(path: String, mode: IOMode, isBinary: Bool) {
        this.mode = mode;
        this.isBinary = isBinary;

        var canOpen = switch (this.mode) {
            case READ: {
                PermissionUtil.checkUser(path, Permission.READ, Scope.USER, UserManager.getCurrentUser());
            }

            case WRITE: {
                PermissionUtil.checkUser(path, Permission.WRITE, Scope.USER, UserManager.getCurrentUser());
            }

            case APPEND: {
                PermissionUtil.checkUser(path, Permission.WRITE, Scope.USER, UserManager.getCurrentUser());
            }

            case READWRITE: {
                if (!PermissionUtil.checkUser(path, Permission.READ, Scope.USER, UserManager.getCurrentUser())) {
                    false;
                }

                PermissionUtil.checkUser(path, Permission.WRITE, Scope.USER, UserManager.getCurrentUser());
            }

            case READAPPEND: {
                if (!PermissionUtil.checkUser(path, Permission.READ, Scope.USER, UserManager.getCurrentUser())) {
                    false;
                }

                PermissionUtil.checkUser(path, Permission.WRITE, Scope.USER, UserManager.getCurrentUser());
            }
        }

        if (!canOpen) {
            err = Error.EACCES(path);
            readHandle = null;
            writeHandle = null;
            return;
        }

        switch (this.mode) {
            case READ: {
                if (this.isBinary) {
                    this.readHandle = IO.open(path, OpenFileMode.BinaryRead);
                } else {
                    this.readHandle = IO.open(path, OpenFileMode.Read);
                }
            }

            case WRITE: {
                if (this.isBinary) {
                    this.writeHandle = IO.open(path, OpenFileMode.BinaryWrite);
                } else {
                    this.writeHandle = IO.open(path, OpenFileMode.Write);
                }

                this.readHandle = null;
            }

            case APPEND: {
                if (this.isBinary) {
                    this.writeHandle = IO.open(path, OpenFileMode.BinaryAppend);
                } else {
                    this.writeHandle = IO.open(path, OpenFileMode.Append);
                }
            }

            case READWRITE: {
                if (this.isBinary) {
                    this.readHandle = IO.open(path, OpenFileMode.BinaryRead);
                    this.writeHandle = IO.open(path, OpenFileMode.BinaryWrite);
                }

                this.readHandle = IO.open(path, OpenFileMode.Read);
                this.writeHandle = IO.open(path, OpenFileMode.Write);
            }

            case READAPPEND: {
                if (this.isBinary) {
                    this.readHandle = IO.open(path, OpenFileMode.BinaryRead);
                    this.writeHandle = IO.open(path, OpenFileMode.BinaryAppend);
                }

                this.readHandle = IO.open(path, OpenFileMode.Read);
                this.writeHandle = IO.open(path, OpenFileMode.Append);
            }
        }
    }

    public function read(?count: Int): EitherType<Error, Pair<String, Int>> {
        var count: EitherType<String, Int> = count != null ? count : "*a";

        if (this.mode != IOMode.READ && this.mode != IOMode.READWRITE && this.mode != IOMode.READAPPEND) {
            return Error.EINVAL("Tried to read from a write-only file");
        }

        var read = readHandle.read(count);

        if (read == "" || read == null) {
            return Error.ENODATA("Reached EOF");
        }

        if (writeHandle != null) {
            writeHandle.seek("set", readHandle.seek());
        }

        return new Pair(read, readHandle.seek());
    }

    public function write(data: String): EitherType<Error, Int> {
        if (this.mode != IOMode.WRITE && this.mode != IOMode.READWRITE && this.mode != IOMode.READAPPEND) {
            return Error.EINVAL("Tried to write to a read-only file");
        }

        writeHandle.write(data);

        if (readHandle != null) {
            readHandle.seek("set", writeHandle.seek());
        }

        return writeHandle.seek();
    }
}