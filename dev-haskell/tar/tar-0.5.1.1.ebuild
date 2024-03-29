# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.6

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Reading, writing and manipulating \".tar\" archive files"
HOMEPAGE="http://hackage.haskell.org/package/tar"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/bytestring-builder-0.10.4.0.2:=[profile?] <dev-haskell/bytestring-builder-0.11:=[profile?]
	<dev-haskell/old-time-1.2:=[profile?]
	>=dev-haskell/semigroups-0.18:=[profile?] <dev-haskell/semigroups-0.20:=[profile?]
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.12
	test? ( dev-haskell/bytestring-handle
		>=dev-haskell/quickcheck-2 <dev-haskell/quickcheck-3
		>=dev-haskell/tasty-0.10 <dev-haskell/tasty-0.12
		>=dev-haskell/tasty-quickcheck-0.8 <dev-haskell/tasty-quickcheck-0.9 )
"

src_prepare() {
	default

	cabal_chdeps \
		'base       >= 4 && < 4.14' 'base       >= 4' \
		'tasty            >= 0.10 && <0.12' 'tasty            >= 0.10' \
		'tasty-quickcheck == 0.8.*' 'tasty-quickcheck >= 0.8'
}
