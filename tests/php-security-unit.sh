#!/usr/bin/env bash
set -euo pipefail

root_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
wp_helper="$root_dir/tag-wp/bin/demyx-php-security"
ols_helper="$root_dir/tag-openlitespeed/bin/demyx-php-security"
tmp_dir=$(mktemp -d)
trap 'rm -rf "$tmp_dir"' EXIT
fixture_root="$tmp_dir/fixture"
wp_fixture="$tmp_dir/demyx-php-security-wp"
ols_fixture="$tmp_dir/demyx-php-security-ols"
sed "s|/usr/local|$fixture_root/usr/local|g" "$wp_helper" > "$wp_fixture"
sed "s|/usr/local|$fixture_root/usr/local|g" "$ols_helper" > "$ols_fixture"
chmod +x "$wp_fixture" "$ols_fixture"
cmp -s "$wp_helper" "$ols_helper"

wp_specs=(
    '/usr/local/bin/php|3|cli|8.3.36|8.3.35|8.3.37'
    '/usr/local/sbin/php-fpm|3|fpm-fcgi|8.3.36|8.3.35|8.3.37'
)
ols_specs=(
    '/usr/local/bin/php|3|cli|8.3.36|8.3.35|8.3.37'
    '/usr/local/sbin/php-fpm|3|fpm-fcgi|8.3.36|8.3.35|8.3.37'
    '/usr/local/lsws/lsphp82/bin/php|2|cli|8.2.35|8.2.34|8.2.36'
    '/usr/local/lsws/lsphp82/bin/lsphp|2|litespeed|8.2.35|8.2.34|8.2.36'
    '/usr/local/lsws/lsphp83/bin/php|3|cli|8.3.36|8.3.35|8.3.37'
    '/usr/local/lsws/lsphp83/bin/lsphp|3|litespeed|8.3.36|8.3.35|8.3.37'
    '/usr/local/lsws/admin/fcgi-bin/admin_php|3|litespeed|8.3.36|8.3.35|8.3.37'
    '/usr/local/lsws/fcgi-bin/lsphp|3|litespeed|8.3.36|8.3.35|8.3.37'
    '/usr/local/lsws/fcgi-bin/lsphp5|3|litespeed|8.3.36|8.3.35|8.3.37'
)
ols_optional_specs=(
    '/usr/local/lsws/fcgi-bin/lsphp7|8.3.36|8.3.35|8.3.37'
    '/usr/local/lsws/admin/fcgi-bin/admin_php5|8.3.36|8.3.35|8.3.37'
    '/usr/local/lsws/admin/fcgi-bin/admin_php.bak|8.3.36|8.3.35|8.3.37'
)

write_fixture() {
    local path="$1"
    local version="$2"
    local sapi="$3"
    local binary="$fixture_root$path"

    mkdir -p "$(dirname "$binary")"
    cat > "$binary" <<EOF
#!/usr/bin/env bash
printf '%s\\n' 'PHP $version ($sapi)'
EOF
    chmod +x "$binary"
}

write_profile_fixtures() {
    local profile="$1"
    local spec path minor sapi minimum below newer

    if [[ "$profile" == wp ]]; then
        for spec in "${wp_specs[@]}"; do
            IFS='|' read -r path minor sapi minimum below newer <<< "$spec"
            write_fixture "$path" "$minimum" "$sapi"
        done
        return
    fi

    for spec in "${ols_specs[@]}"; do
        IFS='|' read -r path minor sapi minimum below newer <<< "$spec"
        write_fixture "$path" "$minimum" "$sapi"
    done
    for spec in "${ols_optional_specs[@]}"; do
        IFS='|' read -r path minimum below newer <<< "$spec"
        write_fixture "$path" "$minimum" litespeed
    done
}

expect_success() {
    local profile="$1"
    local label="$2"
    local helper="$wp_fixture"
    local output
    [[ "$profile" == ols ]] && helper="$ols_fixture"

    if output=$("$helper" "$profile" 2>&1); then
        printf 'PASS %s\n' "$label"
    else
        printf 'FAIL %s: %s\n' "$label" "$output" >&2
        exit 1
    fi
}

expect_failure() {
    local profile="$1"
    local label="$2"
    local expected="$3"
    local helper="$wp_fixture"
    local output
    [[ "$profile" == ols ]] && helper="$ols_fixture"

    if output=$("$helper" "$profile" 2>&1); then
        printf 'FAIL %s: helper unexpectedly passed\n' "$label" >&2
        exit 1
    fi
    if [[ "$output" != *"$expected"* ]]; then
        printf 'FAIL %s: expected %s, got %s\n' "$label" "$expected" "$output" >&2
        exit 1
    fi
    printf 'PASS %s\n' "$label"
}

test_required_surfaces() {
    local profile="$1"
    shift
    local spec path minor sapi minimum below newer binary wrong_branch wrong_sapi

    write_profile_fixtures "$profile"
    for spec in "$@"; do
        IFS='|' read -r path minor sapi minimum below newer <<< "$spec"
        write_fixture "$path" "$below" "$sapi"
        expect_failure "$profile" "$path below minimum" "$path"
        write_fixture "$path" "$minimum" "$sapi"

        binary="$fixture_root$path"
        mv "$binary" "$binary.missing"
        expect_failure "$profile" "$path missing" "$binary"
        mv "$binary.missing" "$binary"

        if [[ "$minor" == 3 ]]; then
            wrong_branch=8.2.99
        else
            wrong_branch=8.3.99
        fi
        write_fixture "$path" "$wrong_branch" "$sapi"
        expect_failure "$profile" "$path wrong branch" 'Wrong PHP branch'
        write_fixture "$path" "$minimum" "$sapi"

        if [[ "$sapi" == cli ]]; then
            wrong_sapi=litespeed
        else
            wrong_sapi=cli
        fi
        write_fixture "$path" "$minimum" "$wrong_sapi"
        expect_failure "$profile" "$path wrong SAPI" 'Wrong PHP SAPI'
        write_fixture "$path" "$minimum" "$sapi"
    done
}

if "$wp_fixture" > /dev/null 2>&1; then
    printf 'FAIL helper accepted a missing profile\n' >&2
    exit 1
else
    status=$?
    [ "$status" -eq 2 ]
fi
if "$ols_fixture" invalid > /dev/null 2>&1; then
    printf 'FAIL helper accepted an invalid profile\n' >&2
    exit 1
else
    status=$?
    [ "$status" -eq 2 ]
fi
printf 'PASS profile usage validation and identical helpers\n'

write_profile_fixtures wp
expect_success wp 'WP profile with no LSAPI binaries'
for spec in "${wp_specs[@]}"; do
    IFS='|' read -r path minor sapi minimum below newer <<< "$spec"
    write_fixture "$path" "$newer" "$sapi"
done
expect_success wp 'WP profile with newer PHP 8.3'
test_required_surfaces wp "${wp_specs[@]}"

write_profile_fixtures ols
expect_success ols 'OLS profile with PHP 8.2.35 and 8.3.36'
for spec in "${ols_specs[@]}"; do
    IFS='|' read -r path minor sapi minimum below newer <<< "$spec"
    write_fixture "$path" "$newer" "$sapi"
done
for spec in "${ols_optional_specs[@]}"; do
    IFS='|' read -r path minimum below newer <<< "$spec"
    write_fixture "$path" "$newer" litespeed
done
expect_success ols 'OLS profile with newer fixed branches'
test_required_surfaces ols "${ols_specs[@]}"

for spec in "${ols_optional_specs[@]}"; do
    IFS='|' read -r path minimum below newer <<< "$spec"
    write_profile_fixtures ols
    write_fixture "$path" "$below" litespeed
    expect_failure ols "$path below minimum" "$path"
done

write_profile_fixtures wp
write_fixture /usr/local/bin/php 8.4.27RC1 cli
expect_failure wp 'prerelease version' 'Malformed or unsupported PHP version'
write_fixture /usr/local/bin/php 8.3.36 cli
cat > "$fixture_root/usr/local/bin/php" <<'EOF'
#!/usr/bin/env bash
printf '\nPHP Warning: Failed loading Xdebug\nPHP 8.3.36 (cli)\n'
EOF
chmod +x "$fixture_root/usr/local/bin/php"
expect_failure wp 'leading Xdebug startup warning' 'Malformed or unsupported PHP version'
printf '#!/usr/bin/env bash\nprintf "not a PHP version\\\\n"\n' > "$fixture_root/usr/local/bin/php"
chmod +x "$fixture_root/usr/local/bin/php"
expect_failure wp 'malformed version output' 'Malformed or unsupported PHP version'
printf '#!/usr/bin/env bash\nexit 23\n' > "$fixture_root/usr/local/bin/php"
chmod +x "$fixture_root/usr/local/bin/php"
expect_failure wp 'version command failure' 'Failed to run PHP version check'

printf 'PHP security profile unit checks passed\n'
