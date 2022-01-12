# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
SLOT=0

inherit autotools git-r3

EGIT_REPO_URI=${PN}
EGIT_COMMIT=rocm-${PV}
EVCS_OFFLINE=T

PATCHES=(
	"${FILESDIR}/fix-dbgapi-path.patch"
	)

DEPEND="
	dev-libs/amd-dbgapi
	dev-util/babeltrace
	"	

KEYWORDS='amd64 arm64 ppc64'

src_configure()
{
	./configure --program-prefix=roc --enable-64-bit-bfd --enable-targets="x86_64-linux-gnu,amdgcn-amd-amdhsa" --disable-ld --disable-gas --disable-gdbserver --disable-sim --enable-tui --disable-gdbtk --disable-shared --with-expat --with-system-zlib --without-guile --with-babeltrace --with-lzma --with-python=python3 --with-rocm-dbgapi=/usr/lib64 --prefix=/usr/lib/ROCgdb

}