package OpenSSL::safe::installdata;

use strict;
use warnings;
use Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($PREFIX
                  $BINDIR $BINDIR_REL
                  $LIBDIR $LIBDIR_REL
                  $INCLUDEDIR $INCLUDEDIR_REL
                  $APPLINKDIR $APPLINKDIR_REL
                  $ENGINESDIR $ENGINESDIR_REL
                  $MODULESDIR $MODULESDIR_REL
                  $PKGCONFIGDIR $PKGCONFIGDIR_REL
                  $CMAKECONFIGDIR $CMAKECONFIGDIR_REL
                  $VERSION @LDLIBS);

our $PREFIX             = 'C:\Program Files\OpenSSL';
our $BINDIR             = 'C:\Program Files\OpenSSL\bin';
our $BINDIR_REL         = 'bin';
our $LIBDIR             = 'C:\Program Files\OpenSSL\lib';
our $LIBDIR_REL         = 'lib';
our $INCLUDEDIR         = 'C:\Program Files\OpenSSL\include';
our $INCLUDEDIR_REL     = 'include';
our $APPLINKDIR         = 'C:\Program Files\OpenSSL\include\openssl';
our $APPLINKDIR_REL     = 'include/openssl';
our $ENGINESDIR         = 'C:\Program Files\OpenSSL\lib\engines-3';
our $ENGINESDIR_REL     = 'lib\engines-3';
our $MODULESDIR         = 'C:\Program Files\OpenSSL\lib\ossl-modules';
our $MODULESDIR_REL     = 'lib\ossl-modules';
our $PKGCONFIGDIR       = 'C:\Program Files\OpenSSL';
our $PKGCONFIGDIR_REL   = '.';
our $CMAKECONFIGDIR     = 'C:\Program Files\OpenSSL\lib\cmake\OpenSSL';
our $CMAKECONFIGDIR_REL = 'lib\cmake\OpenSSL';
our $VERSION            = '3.3.0';
our @LDLIBS             =
    # Unix and Windows use space separation, VMS uses comma separation
    split(/ +| *, */, 'ws2_32.lib gdi32.lib advapi32.lib crypt32.lib user32.lib ');

1;
