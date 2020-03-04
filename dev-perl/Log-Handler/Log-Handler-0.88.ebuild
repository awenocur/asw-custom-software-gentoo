EAPI=7

DIST_AUTHOR=BLOONIX
DIST_VERSION=${PV}
inherit perl-module

DESCRIPTION="Log messages to several outputs"

SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	virtual/perl-Carp
	virtual/perl-Data-Dumper
	dev-perl/Params-Validate
	virtual/perl-Time-HiRes
	dev-perl/DBI
	dev-perl/Net-SMTP-SSL
	dev-perl/YAML
"

DEPEND="${RDEPEND}
	test? (
		dev-perl/Test-Simple
	)
	dev-perl/Module-Build
"
