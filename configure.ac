#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.71])
AC_INIT([pico_sdk_installer], [1.0.0], [])
AM_INIT_AUTOMAKE([foreign])

LOCAL_PREFIX=/usr/local/sbin:/usr/local/bin$PATH_SEPARATOR

AC_MSG_CHECKING([whether to search optional path])
AC_ARG_WITH([opt-path],
  [AS_HELP_STRING([--with-opt-path@<:@=PATH@:>@],
    [search optional PATH @{:@default: /opt/local/bin@:}@])],
  [], [with_opt_path=check])
if test ."$with_opt_path" = .'yes' || test ."$with_opt_path" = .'check'; then
    if test -d /opt/local/bin; then
        OPT_PREFIX=/opt/local/sbin${PATH_SEPARATOR}/opt/local/bin
    fi
elif test ! ."$with_opt_path" = .'no'; then
    if test -d "$with_opt_path"; then
        OPT_PREFIX=${with_opt_path}
    else
        AC_MSG_WARN([${with_opt_path}: No such file or directory])
    fi
fi
AC_MSG_RESULT([${OPT_PREFIX:-no}])
OPT_PREFIX=${OPT_PREFIX:+"${OPT_PREFIX}${PATH_SEPARATOR}"}

# Checks for programs.
AC_PATH_PROG([APT_CMD],      [apt])
AC_PATH_PROG([AUTOUPDATE_CMD],      [autoupdate])

AC_PATH_PROGS([CAT_CMD],     [gcat cat],         [], [$OPT_PREFIX$PATH])

AC_PATH_PROG([CMAKE_CMD],    [cmake],            [], [$OPT_PREFIX$PATH])
AC_PATH_PROG([DNF_CMD],      [dnf],              [], [$LOCAL_PREFIX$PATH])
AC_PATH_PROG([ED_CMD],       [ed],               [], [$LOCAL_PREFIX$PATH])
AC_PATH_PROG([GIT_CMD],      [git],              [], [$OPT_PREFIX$PATH])

AC_PATH_PROGS([GREP_CMD],    [ggrep grep],       [], [$OPT_PREFIX$PATH])
AC_PATH_PROGS([ID_CMD],      [gid id],           [], [$OPT_PREFIX$PATH])
AC_PATH_PROGS([INSTALL_CMD], [ginstall install], [], [$OPT_PREFIX$PATH])
AC_PATH_PROGS([LN_CMD],      [gln ln],           [], [$OPT_PREFIX$PATH])
AC_PATH_PROGS([LS_CMD],      [gls ls],           [], [$OPT_PREFIX$PATH])

AC_PATH_PROG([LSUSB_CMD],    [lsusb],            [], [$OPT_PREFIX$PATH])

AC_PATH_PROGS([MAKE_CMD],    [gmake make],       [], [$OPT_PREFIX$PATH])

AC_PATH_PROG([OPENOCD_CMD],  [openocd],          [], [$OPT_PREFIX$PATH])
AC_PATH_PROG([PS_CMD],       [ps],               [], [$OPT_PREFIX$PATH])
AC_PATH_PROG([NPROC_CMD],    [nproc],            [], [$OPT_PREFIX$PATH])
AC_PATH_PROG([PORT_CMD],     [port],             [], [$OPT_PREFIX$PATH])
AC_PATH_PROG([SCREEN_CMD],   [screen],           [], [$OPT_PREFIX$PATH])

AC_PATH_PROGS([SED_CMD],     [gsed sed],         [], [$OPT_PREFIX$PATH])
AC_PATH_PROGS([SORT_CMD],    [gsort sort],       [], [$OPT_PREFIX$PATH])

AC_PATH_PROG([SUDO_CMD],     [sudo],             [], [$OPT_PREFIX$PATH])
AC_PATH_PROG([TR_CMD],       [tr],               [], [$OPT_PREFIX$PATH])
AC_PATH_PROG([UDEVADM_CMD],  [udevadm],          [], [$OPT_PREFIX$PATH])


# Checks for libraries.

# Checks for header files.

# Checks for typedefs, structures, and compiler characteristics.

# Checks for library functions.

AC_CONFIG_FILES([Makefile])
AC_CONFIG_FILES([build-sdk-and-upy], [chmod +x build-sdk-and-upy])
AC_CONFIG_FILES([ttyusb], [chmod +x ttyusb; ln -sf ttyusb ttypico])
AC_CONFIG_FILES([openocd-picoprobe], [chmod +x openocd-picoprobe])

AC_OUTPUT
