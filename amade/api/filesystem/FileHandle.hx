package amade.api.filesystem;

import amade.api.Pair;
import amade.api.filesystem.FilePermission.Scope;
import amade.api.multiuser.UserManager;
import amade.api.filesystem.FilePermission.Permission;
import amade.api.filesystem.FilePermission.PermissionUtil;
import amade.api.Error;
import haxe.extern.EitherType;
import cc.IO;
import cc.IO.OpenFileMode;
import cc.IO.LLFileHandle;

class FileHandle {
    private final readHandle: LLFileHandle;
    private final writeHandle: LLFileHandle;
    public final mode: Mode;
    public final isBinary: Bool;

    public final err: Error;

    public function new(path: String, mode: Mode, isBinary: Bool) {
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
            err = Error.EACCES;
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

        if (this.mode != Mode.READ && this.mode != Mode.READWRITE && this.mode != Mode.READAPPEND) {
            return Error.EINVAL;
        }

        var read = readHandle.read(count);

        if (read == "" || read == null) {
            return Error.ENODATA;
        }

        if (writeHandle != null) {
            writeHandle.seek("set", readHandle.seek());
        }

        return new Pair(read, readHandle.seek());
    }

    public function write(data: String): EitherType<Error, Int> {
        if (this.mode != Mode.WRITE && this.mode != Mode.READWRITE && this.mode != Mode.READAPPEND) {
            return Error.EINVAL;
        }

        writeHandle.write(data);

        if (readHandle != null) {
            readHandle.seek("set", writeHandle.seek());
        }

        return writeHandle.seek();
    }
}

enum Mode {
    READ;
    WRITE;
    APPEND;

    READWRITE;
    READAPPEND;
}