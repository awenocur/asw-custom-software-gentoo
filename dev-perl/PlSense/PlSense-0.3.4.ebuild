# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit perl-module
SRC_URI="https://github.com/aki2o/plsense/releases/download/v0.3.4/PlSense-0.3.4.tar.gz"

DESCRIPTION="a development tool for Perl using the type inference by analyzing source code"

SLOT="0"

KEYWORDS="amd64 ~ppc ~ppc64 ~x86"

RDEPEND=">=dev-perl/PPI-1.236
	>=dev-perl/Class-Std-0.13.0
	>=dev-perl/Class-Std-Storable-0.0.1
	>=dev-perl/List-AllUtils-0.90.0
	>=dev-perl/Log-Handler-0.8.8
	virtual/perl-Exporter
	>=dev-perl/Try-Tiny-0.300.0
	>=dev-perl/List-AllUtils-0.90.0
	>=dev-perl/Config-Tiny-2.230.0
	>=dev-perl/Cache-Cache-1.80.0
	>=dev-perl/Module-Pluggable-5.200.0
"

DEPEND="${RDEPEND}
	dev-perl/Module-Build
	dev-perl/Module-Install
"
