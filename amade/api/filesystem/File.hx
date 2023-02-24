package amade.api.filesystem;

import lua.Table;
import amade.api.filesystem.FilePermission.Scope;
import amade.api.filesystem.FilePermission.Permission;

class File {
    public final path: String;
    private var permissions: Table<Permission, Scope> = Table.create();

    public function new(path: String) {
        this.path = path;

        
    }

    
}