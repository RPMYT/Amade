package amade.api;

class Pair<L, R> {
    public final left: L;
    public final right: R;

    public function new(left: L, right: R) {
        this.left = left;
        this.right = right;
    }
}