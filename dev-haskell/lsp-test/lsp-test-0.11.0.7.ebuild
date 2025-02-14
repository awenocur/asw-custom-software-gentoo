# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.6

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Functional test framework for LSP servers"
HOMEPAGE="https://github.com/bubba/lsp-test#readme"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="amd64 ~x86"
IUSE="dummyserver"

RDEPEND="dev-haskell/aeson:=[profile?]
	dev-haskell/aeson-pretty:=[profile?]
	dev-haskell/ansi-terminal:=[profile?]
	dev-haskell/async:=[profile?]
	dev-haskell/conduit:=[profile?]
	>=dev-haskell/conduit-parse-0.2:=[profile?] <dev-haskell/conduit-parse-0.3:=[profile?]
	dev-haskell/data-default:=[profile?]
	dev-haskell/diff:=[profile?]
	>=dev-haskell/glob-0.9:=[profile?] <dev-haskell/glob-0.11:=[profile?]
	dev-haskell/lens:=[profile?]
	dev-haskell/mtl:=[profile?]
	>=dev-haskell/parser-combinators-1.2:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/unordered-containers:=[profile?]
	>=dev-lang/ghc-8.2.1:=
	dummyserver? ( >=dev-haskell/haskell-lsp-0.23:=[profile?] <dev-haskell/haskell-lsp-0.24:=[profile?] )
	!dummyserver? ( >=dev-haskell/haskell-lsp-0.22:=[profile?] <dev-haskell/haskell-lsp-0.24:=[profile?] )
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.0.0.2
	test? ( dev-haskell/hspec )
"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag dummyserver dummyserver)
}
