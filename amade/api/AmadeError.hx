package amade.api;

enum AmadeError {
    // System Errors

    EPERM; // Operation not permitted
    ESRCH; // Process doesn't exist
    EINVAL; // Invalid argument
    ENOTTY; // Not a terminal
    ENOSYS; // Unimplemented system call
    ENODATA; // No data was returned
    ETIME; // Timer expired
    EOWNERDEAD; // Process owner died
    ENOTSUP; // Operation not supported

    // I/O Errors

    EIO; // Generic I/O error
    ENODEV; // No such device exists
    EPIPE; // Pipe no longer exists
    ENOTBLK; // Not a block device

    // Filesystem Errors

    EFBIG; // File too big
    ENOSPC; // No space left on device
    EACCES; // Access not permitted
    ENOTEMPTY; // Directory isn't empty
    ENOTDIR; // File isn't a directory
    EISDIR; // File is a directory
    ENOENT; // File or directory doesn't exist
    EEXIST; // File or directory already exists
    EROFS; // Readonly filesystem

    // Network Errors

    ECOMM; // Communication failure
    EMSGSIZE; // Message too big
    EOPNOTSUPP; // Operation not supported for protocol
    EADDRINUSE; // Address already in use
    EADDRNOTAVAIL; // Address not available
    ENETDOWN; // Network is down
    ENETUNREACH; // Network is unreachable
    ECONNABORTED; // Connection aborted
    ECONNRESET; // Connection reset
    EISCONN; // Already connected
    ENOTCONN; // Not connected
    ESHUTDOWN; // Endpoint shut down
    ETIMEDOUT; // Timed out
    ECONNREFUSED; // Connection refused
    EHOSTDOWN; // Host is down
    EHOSTUNREACH; // Host is unreachable
    EALREADY; // Operation already in progress

    // Amade Errors
    EUNKNOWN; // Unknown error
}