package amade.api.filesystem;

import amade.api.multiuser.Group;
import amade.api.multiuser.User;
import sys.io.File;
import haxe.extern.EitherType;
import amade.api.Error;
import amade.api.filesystem.FileHandle;
import lua.Table;

enum Permission {
    READ;
    WRITE;
    EXECUTE;   
}

enum Scope {
    ALL;
    GROUP;
    USER;
}

class PermissionUtil {
    private static var initialized: Bool;
    private static var FilePermissionList: Table<String, Table<Permission, Scope>> = Table.create();
    private static var PermissionDatabaseHandle: FileHandle;

    public static function init(): EitherType<Error, Void> {
        if (initialized) {
            return Error.EALREADY;
        }

        PermissionDatabaseHandle = new FileHandle("/System/Permissions.txt", Mode.READWRITE, false);

        return null;
    }

    public static function get(file: String): Table<Permission, Scope> {
        var permissions: Table<Permission, Scope> = Table.create();

        return permissions;
    }

    public static function checkUser(file: String, permission: Permission, scope: Scope, user: User): Bool {
        return true; // TODO: proper file permissions
    }

    public static function checkGroup(file: String, permission: Permission, scope: Scope, group: Group): Bool {
        return true; // TODO: proper file permissions
    }
}