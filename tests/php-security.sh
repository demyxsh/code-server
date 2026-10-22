#!/usr/bin/env bash
set -euo pipefail

if (($# < 2)); then
    printf 'Usage: %s wp|ols IMAGE [IMAGE ...]\n' "${0##*/}" >&2
    exit 2
fi

profile="$1"
if [[ "$profile" != wp && "$profile" != ols ]]; then
    printf 'Unsupported PHP security profile: %s\n' "$profile" >&2
    exit 2
fi
shift

container_test=$(cat <<'EOF'
assert_extensions() {
    binary="$1"
    required="$2"
    if ! missing=$(PHP_TEST_REQUIRED_EXTENSIONS="$required" "$binary" -r '
$required = explode(",", getenv("PHP_TEST_REQUIRED_EXTENSIONS"));
$missing = array_filter($required, static fn($extension) => !extension_loaded($extension));
echo implode(",", $missing);
' 2>&1); then
        printf "Failed to inspect extensions with %s\n" "$binary" >&2
        exit 1
    fi
    if [ -n "$missing" ]; then
        printf "Missing extensions in %s: %s\n" "$binary" "$missing" >&2
        exit 1
    fi
    printf "Extensions present in %s: %s\n" "$binary" "$required"
}

assert_xdebug() {
    php_binary="$1"
    assert_extensions "$php_binary" xdebug
    if ! zend_extension=$("$php_binary" -r '
if (!in_array("Xdebug", get_loaded_extensions(true), true)) {
    fwrite(STDERR, "Xdebug is not loaded as a Zend extension\n");
    exit(1);
}
' 2>&1); then
        printf "Failed to verify Xdebug Zend extension with %s: %s\n" "$php_binary" "$zend_extension" >&2
        exit 1
    fi
    if [ -n "$zend_extension" ]; then
        printf "Unexpected PHP output from %s while verifying Xdebug Zend extension: %s\n" "$php_binary" "$zend_extension" >&2
        exit 1
    fi
    printf "Xdebug is loaded as a Zend extension in %s\n" "$php_binary"
}

if [ "$(id -u)" -ne 1000 ]; then
    printf "Expected UID 1000, got %s\n" "$(id -u)" >&2
    exit 1
fi
command -v code-server >/dev/null

assert_extensions /usr/local/bin/php exif,gd,mysqli,"Zend OPcache",pdo_mysql,sockets,zip,ssh2,imagick
if [ "$PHP_SECURITY_PROFILE" = wp ]; then
    assert_xdebug /usr/local/bin/php
fi
if [ "$PHP_SECURITY_PROFILE" = ols ]; then
    assert_extensions /usr/local/lsws/lsphp82/bin/php curl,imagick,intl,mysqli,redis
    assert_extensions /usr/local/lsws/lsphp83/bin/php curl,imagick,intl,mysqli,redis
    assert_xdebug /usr/local/lsws/lsphp82/bin/php
    assert_xdebug /usr/local/lsws/lsphp83/bin/php
fi
EOF
)

for image in "$@"; do
    printf 'Checking PHP security profile %s in %s\n' "$profile" "$image"
    # LSAPI needs writable temporary lock files with a read-only root.
    docker run --rm --network none --read-only --tmpfs /tmp:rw,noexec,nosuid,nodev,size=64m,mode=1777 --entrypoint /usr/local/bin/demyx-php-security "$image" "$profile"
    docker run --rm --network none --read-only --tmpfs /tmp:rw,noexec,nosuid,nodev,size=64m,mode=1777 -e PHP_SECURITY_PROFILE="$profile" --entrypoint /bin/sh "$image" -ec "$container_test"
done
