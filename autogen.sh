#!/bin/sh
#
# @(#)autogen.sh
#
# This script generates a GNU Autoconf configure script.
#
script_name=$(basename $0)

case "$1" in
    -h*|--h*)
        echo "Usage: $script_name [-h|--help] [-s|--silent]"
        exit
        ;;
esac

verbose='true'
case "$1" in
    -s*|--s*)
        verbose='false'
        shift
        ;;
esac

srcdir=$(dirname $0)
abs_srcdir="$(cd "$srcdir" && pwd)"
if [ ! -w "$abs_srcdir" ]; then
    echo "$script_name: $abs_srcdir: Permission denied"
    exit 2
fi

aclocal_cmd=$(which aclocal 2>/dev/null)
exit_status=$?
if test $exit_status -ne 0; then
    cat <<EOF
$script_name: aclocal: File not found
Please verify installation of GNU Autoconf, Automake, and Libtool
before running this script.
EOF
    exit $exit_status
fi

automake_cmd=$(which automake 2>/dev/null)
exit_status=$?
if test $exit_status -ne 0; then
    cat <<EOF
$script_name: automake: File not found
Please verify installation of GNU Autoconf, Automake, Gettext and
Libtool before running this script.
EOF
    exit $exit_status
fi

autoreconf_cmd=$(which autoreconf 2>/dev/null)
exit_status=$?
if test $exit_status -ne 0; then
    cat <<EOF
$script_name: autoreconf: File not found
Please verify installation of GNU Autoconf, Automake, Gettext and
Libtool before running this script.
EOF
    exit $exit_status
fi

$verbose && cat <<EOF
$script_name: Running:
  cd "$abs_srcdir" &&
  aclocal --warnings=gnu >&2

EOF

aclocal_output=$(
    cd "$abs_srcdir" &&
        aclocal --warnings=gnu 2>&1
               )
exit_status=$?
if test $exit_status -ne 0; then
    cat <<EOF
$script_name:
$aclocal_output
EOF
    exit $exit_status
fi

$verbose && cat <<EOF
$script_name: Running:
  cd "$abs_srcdir" &&
  automake --verbose --add-missing --copy >&2

EOF

automake_output=$(
    cd "$abs_srcdir" &&
        automake --verbose --add-missing --copy 2>&1
               )
exit_status=$?
if test $exit_status -ne 0; then
    cat <<EOF
$script_name:
$automake_output
EOF
    exit $exit_status
fi

$verbose && cat <<EOF
$script_name: Running:
  cd "$abs_srcdir" &&
  autoreconf --verbose --install -I ./m4 >&2

EOF

autoconf_output=$(
    cd "$abs_srcdir" &&
        autoreconf --verbose --install -I ./m4 2>&1
               )
exit_status=$?
if test $exit_status -ne 0; then
    cat <<EOF
$script_name:
$autoconf_output
EOF
    exit $exit_status
fi

if $verbose; then
    echo "$script_name:" >&2
    cat >&2 <<'EOF'
========================================================================

     Automake and autoreconf appear to have completed successfully.
     To continue, optionally create and cd to a build directory, then
     run:

             $ $top_srcdir/configure
             $ make
             $ sudo make install

------------------------------------------------------------------------
EOF
fi
