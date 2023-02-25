package amade.api;

import lua.Table;

class Command {
    public function execute(?args: Array<String>): Table<Any, Any> {
        var table = Table.create();
        if (args != null) {
            var index = 1;
            for (arg in args) {
                table[index++] = arg;
            }
        }
        return table;
    }
}