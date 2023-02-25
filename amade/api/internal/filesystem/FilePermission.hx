package amade.api.internal.filesystem;

import amade.api.internal.multiuser.Group;
import amade.api.internal.multiuser.User;
import sys.io.File;
import haxe.extern.EitherType;
import amade.util.Error;
import amade.api.internal.filesystem.FileHandle;
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
            return Error.EALREADY("PermissionUtil already initialized!!");
        }

        PermissionDatabaseHandle = new FileHandle("/System/Permissions.txt", IOMode.READWRITE, false);

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