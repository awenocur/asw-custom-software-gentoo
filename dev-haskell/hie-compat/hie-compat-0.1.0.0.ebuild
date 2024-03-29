# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.6

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="HIE files for GHC 8.6 and other HIE file backports"
HOMEPAGE="http://hackage.haskell.org/package/hie-compat"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="amd64 ~x86"
IUSE="ghc-lib"

RDEPEND=">=dev-lang/ghc-8.0.1:=
	ghc-lib? ( dev-haskell/ghc-lib:=[profile?] )
	!ghc-lib? ( dev-lang/ghc:=[profile?] )
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.24.0.0
"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag ghc-lib ghc-lib)
}
