# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.6

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Anything that associates"
HOMEPAGE="https://github.com/ekmett/semigroups/"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="amd64 ~x86"
IUSE="+binary +bytestring bytestring-builder +containers +deepseq +hashable +tagged +template-haskell +text +transformers +unordered-containers"

RDEPEND="!bytestring? ( >=dev-haskell/nats-0.1:=[profile?] <dev-haskell/nats-2:=[profile?]
			>=dev-lang/ghc-7.8.2:=
			tagged? ( >=dev-haskell/tagged-0.4.4:=[profile?] <dev-haskell/tagged-1:=[profile?] )
			text? ( >=dev-haskell/text-0.10:=[profile?] <dev-haskell/text-2:=[profile?] )
			transformers? ( >=dev-haskell/transformers-compat-0.5:=[profile?] <dev-haskell/transformers-compat-1:=[profile?] ) )
	!bytestring-builder? ( >=dev-haskell/nats-0.1:=[profile?] <dev-haskell/nats-2:=[profile?]
				>=dev-lang/ghc-7.8.2:=
				tagged? ( >=dev-haskell/tagged-0.4.4:=[profile?] <dev-haskell/tagged-1:=[profile?] )
				text? ( >=dev-haskell/text-0.10:=[profile?] <dev-haskell/text-2:=[profile?] )
				transformers? ( >=dev-haskell/transformers-compat-0.5:=[profile?] <dev-haskell/transformers-compat-1:=[profile?] ) )
	hashable? ( !bytestring? ( >=dev-haskell/hashable-1.2.5.0:=[profile?] <dev-haskell/hashable-1.4:=[profile?]
					tagged? ( >=dev-haskell/tagged-0.4.4:=[profile?] <dev-haskell/tagged-1:=[profile?] )
					text? ( >=dev-haskell/text-0.10:=[profile?] <dev-haskell/text-2:=[profile?] )
					transformers? ( >=dev-haskell/transformers-compat-0.5:=[profile?] <dev-haskell/transformers-compat-1:=[profile?] )
					unordered-containers? ( >=dev-haskell/unordered-containers-0.2:=[profile?] <dev-haskell/unordered-containers-0.3:=[profile?] ) )
			!bytestring-builder? ( >=dev-haskell/hashable-1.2.5.0:=[profile?] <dev-haskell/hashable-1.4:=[profile?]
						tagged? ( >=dev-haskell/tagged-0.4.4:=[profile?] <dev-haskell/tagged-1:=[profile?] )
						text? ( >=dev-haskell/text-0.10:=[profile?] <dev-haskell/text-2:=[profile?] )
						transformers? ( >=dev-haskell/transformers-compat-0.5:=[profile?] <dev-haskell/transformers-compat-1:=[profile?] )
						unordered-containers? ( >=dev-haskell/unordered-containers-0.2:=[profile?] <dev-haskell/unordered-containers-0.3:=[profile?] ) ) )
"
DEPEND="${RDEPEND}
	!bytestring? ( >=dev-haskell/cabal-1.18.1.3 )
	!bytestring-builder? ( >=dev-haskell/cabal-1.18.1.3 )
"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag binary binary) \
		$(cabal_flag bytestring bytestring) \
		$(cabal_flag bytestring-builder bytestring-builder) \
		$(cabal_flag containers containers) \
		$(cabal_flag deepseq deepseq) \
		$(cabal_flag hashable hashable) \
		$(cabal_flag tagged tagged) \
		$(cabal_flag template-haskell template-haskell) \
		$(cabal_flag text text) \
		$(cabal_flag transformers transformers) \
		$(cabal_flag unordered-containers unordered-containers)
}
