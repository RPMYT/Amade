package amade.api.internal.multiuser;

class User {
    public static final RootUser = new User("root");

    public final name: String;

    public function new(name: String) {
        this.name = name;
    }
}