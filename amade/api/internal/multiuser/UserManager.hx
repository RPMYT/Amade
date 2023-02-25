package amade.api.internal.multiuser;

import amade.api.internal.multiuser.User;

class UserManager {
    private static var current: User;

    public static function getCurrentUser(): User {
        return current;
    }
}