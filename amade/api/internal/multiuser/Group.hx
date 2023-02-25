package amade.api.internal.multiuser;

import amade.api.internal.multiuser.User;
import lua.Table;

class Group {
    public final name: String;
    private var members: List<User> = new List();

    public function new(name: String) {
        this.name = name;
    }

    public function isUserMember(user: User) {
        var isTrue = false;
        var iterator = this.members.iterator();
        
        do {
            if (iterator.next() == user) {
                isTrue = true;
            }
        } while (iterator.hasNext());

        return isTrue;
    }
}