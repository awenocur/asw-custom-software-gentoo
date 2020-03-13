# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DIST_AUTHOR=LEONT
DIST_VERSION=${PV}
inherit perl-module

DESCRIPTION="This module has been extracted into a separate distribution and renamed Module::Metadata. This module is kept as a subclass wrapper for compatibility."

SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND=">=virtual/perl-version-0.870"
DEPEND="${RDEPEND}
	dev-perl/Module-Build"

SRC_TEST="do parallel"
