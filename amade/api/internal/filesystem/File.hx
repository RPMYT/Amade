package amade.api.internal.filesystem;

import lua.Table;
import amade.api.internal.filesystem.FilePermission.Scope;
import amade.api.internal.filesystem.FilePermission.Permission;

class File {
    public final path: String;
    private var permissions: Table<Permission, Scope> = Table.create();

    public function new(path: String) {
        this.path = path;

        
    }

    
}