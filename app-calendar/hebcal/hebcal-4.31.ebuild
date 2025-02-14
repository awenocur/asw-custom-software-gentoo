# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A perpetual Jewish Calendar"
HOMEPAGE="https://www.hebcal.com"
SRC_URI="https://github.com/hebcal/hebcal/archive/v${PV}.zip -> hebcal-${PV}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm arm64 ppc ppc64 x86"

src_prepare() {
      default
      autoreconf
      automake --add-missing
      autoreconf
}