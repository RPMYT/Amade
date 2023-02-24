package amade.api.multiuser;

import amade.api.multiuser.User;

class UserManager {
    private static var current: User;

    public static function getCurrentUser(): User {
        return current;
    }
}