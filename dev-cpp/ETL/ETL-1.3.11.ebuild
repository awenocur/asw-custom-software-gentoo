# By eroen <eroen-overlay@occam.eroen.eu>, 2018
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.

EAPI=6

inherit eutils cmake-utils

DESCRIPTION="Template library used by synfig"
HOMEPAGE="https://www.synfig.org"
SRC_URI="https://github.com/synfig/synfig/archive/v$PV.tar.gz -> synfig-$PV.tar.gz"
S=${WORKDIR}/synfig-$PV/$PN

LICENSE="GPL-2+"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
