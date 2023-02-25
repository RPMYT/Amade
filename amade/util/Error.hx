package amade.util;

enum Error {
    // System Errors

    EPERM(message: String); // Operation not permitted
    ESRCH(message: String); // Process doesn't exist
    EINVAL(message: String); // Invalid argument
    ENOTTY(message: String); // Not a terminal
    ENOSYS; // Unimplemented system call
    ENODATA(message: String); // No data was returned
    ETIME(message: String); // Timer expired
    EOWNERDEAD(message: String); // Process owner died
    ENOTSUP(message: String); // Operation not supported

    // I/O Errors

    EIO(message: String); // Generic I/O error
    ENODEV(message: String); // No such device exists
    EPIPE(message: String); // Pipe no longer exists
    ENOTBLK(message: String); // Not a block device

    // Filesystem Errors

    EFBIG(message: String); // File too big
    ENOSPC(message: String); // No space left on device
    EACCES(message: String); // Access not permitted
    ENOTEMPTY(message: String); // Directory isn't empty
    ENOTDIR(message: String); // File isn't a directory
    EISDIR(message: String); // File is a directory
    ENOENT(message: String); // File or directory doesn't exist
    EEXIST(message: String); // File or directory already exists
    EROFS(message: String); // Readonly filesystem

    // Network Errors

    ECOMM(message: String); // Communication failure
    EMSGSIZE(message: String); // Message too big
    EOPNOTSUPP(message: String); // Operation not supported for protocol
    EADDRINUSE(message: String); // Address already in use
    EADDRNOTAVAIL(message: String); // Address not available
    ENETDOWN(message: String); // Network is down
    ENETUNREACH(message: String); // Network is unreachable
    ECONNABORTED(message: String); // Connection aborted
    ECONNRESET(message: String); // Connection reset
    EISCONN(message: String); // Already connected
    ENOTCONN(message: String); // Not connected
    ESHUTDOWN(message: String); // Endpoint shut down
    ETIMEDOUT(message: String); // Timed out
    ECONNREFUSED(message: String); // Connection refused
    EHOSTDOWN(message: String); // Host is down
    EHOSTUNREACH(message: String); // Host is unreachable
    EALREADY(message: String); // Operation already in progress

    // Amade Errors
    EUNKNOWN; // Unknown error
}