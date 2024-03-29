# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.6

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Supports using pandoc with citeproc"
HOMEPAGE="https://github.com/jgm/pandoc-citeproc"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="amd64 ~x86"
IUSE="+bibutils debug embed-data-files static test-citeproc unicode-collation"

RDEPEND=">=dev-haskell/aeson-0.7:=[profile?] <dev-haskell/aeson-1.6:=[profile?]
	>=dev-haskell/aeson-pretty-0.8:=[profile?]
	dev-haskell/attoparsec:=[profile?]
	>=dev-haskell/base-compat-0.9:=[profile?]
	dev-haskell/data-default:=[profile?]
	>=dev-haskell/hsyaml-0.2:=[profile?] <dev-haskell/hsyaml-0.3:=[profile?]
	>=dev-haskell/hsyaml-aeson-0.2:=[profile?] <dev-haskell/hsyaml-aeson-0.3:=[profile?]
	dev-haskell/libyaml:=[profile?]
	dev-haskell/mtl:=[profile?]
	<dev-haskell/network-3.2:=[profile?]
	dev-haskell/old-locale:=[profile?]
	>=app-text/pandoc-2.8:=[profile?] <app-text/pandoc-2.12:=[profile?]
	>=dev-haskell/pandoc-types-1.20:=[profile?] <dev-haskell/pandoc-types-1.23:=[profile?]
	dev-haskell/parsec:=[profile?]
	dev-haskell/safe:=[profile?]
	>=dev-haskell/semigroups-0.18:=[profile?] <dev-haskell/semigroups-0.20:=[profile?]
	>=dev-haskell/setenv-0.1:=[profile?] <dev-haskell/setenv-0.2:=[profile?]
	dev-haskell/split:=[profile?]
	dev-haskell/syb:=[profile?]
	dev-haskell/tagsoup:=[profile?]
	dev-haskell/text:=[profile?]
	>=dev-haskell/unordered-containers-0.2:=[profile?] <dev-haskell/unordered-containers-0.3:=[profile?]
	>=dev-haskell/xml-conduit-1.2:=[profile?] <dev-haskell/xml-conduit-1.10:=[profile?]
	>=dev-haskell/yaml-0.11:=[profile?]
	>=dev-lang/ghc-7.4.1:=
	bibutils? ( >=dev-haskell/hs-bibutils-6.4:=[profile?] )
	debug? ( dev-haskell/pretty-show:=[profile?] )
	embed-data-files? ( >=dev-haskell/file-embed-0.0:=[profile?] <dev-haskell/file-embed-0.1:=[profile?] )
	test-citeproc? ( >=dev-haskell/temporary-1.1:=[profile?]
				>=dev-haskell/vector-0.10:=[profile?] )
	!test-citeproc? ( dev-haskell/vector:=[profile?] )
	unicode-collation? ( dev-haskell/text-icu:=[profile?] )
	!unicode-collation? ( >=dev-haskell/rfc5051-0.2:=[profile?] <dev-haskell/rfc5051-0.3:=[profile?] )
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.12
	test-citeproc? ( unknown-build-tool/pandoc-citeproc )
	!test-citeproc? ( test? ( >=dev-haskell/temporary-1.1 ) )
"

src_prepare() {
	default

	cabal_chdeps \
		'pandoc-types >= 1.20 && < 1.22' 'pandoc-types >= 1.20 && < 1.23' \
		'pandoc >= 2.8 && < 2.11' 'pandoc >= 2.8 && < 2.12'
}

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag bibutils bibutils) \
		$(cabal_flag debug debug) \
		$(cabal_flag embed-data-files embed_data_files) \
		$(cabal_flag static static) \
		$(cabal_flag test-citeproc test_citeproc) \
		$(cabal_flag unicode-collation unicode_collation)
}
