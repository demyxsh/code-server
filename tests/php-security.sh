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
'); then
        printf "Failed to inspect extensions with %s\n" "$binary" >&2
        exit 1
    fi
    if [ -n "$missing" ]; then
        printf "Missing extensions in %s: %s\n" "$binary" "$missing" >&2
        exit 1
    fi
    printf "Extensions present in %s: %s\n" "$binary" "$required"
}

if [ "$(id -u)" -ne 1000 ]; then
    printf "Expected UID 1000, got %s\n" "$(id -u)" >&2
    exit 1
fi
command -v code-server >/dev/null

assert_extensions /usr/local/bin/php exif,gd,mysqli,"Zend OPcache",pdo_mysql,sockets,zip,ssh2,imagick
if [ "$PHP_SECURITY_PROFILE" = wp ]; then
    assert_extensions /usr/local/bin/php xdebug
fi
if [ "$PHP_SECURITY_PROFILE" = ols ]; then
    assert_extensions /usr/local/lsws/lsphp82/bin/php curl,imagick,intl,mysqli,redis
    assert_extensions /usr/local/lsws/lsphp83/bin/php curl,imagick,intl,mysqli,redis
fi
EOF
)

for image in "$@"; do
    printf 'Checking PHP security profile %s in %s\n' "$profile" "$image"
    docker run --rm --network none --read-only --entrypoint /usr/local/bin/demyx-php-security "$image" "$profile"
    docker run --rm --network none --read-only -e PHP_SECURITY_PROFILE="$profile" --entrypoint /bin/sh "$image" -ec "$container_test"
done
