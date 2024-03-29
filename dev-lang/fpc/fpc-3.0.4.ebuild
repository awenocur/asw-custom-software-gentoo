# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit prefix toolchain-funcs

HOMEPAGE="https://www.freepascal.org/"
DESCRIPTION="Free Pascal Compiler"
SRC_URI="mirror://sourceforge/freepascal/fpcbuild-${PV}.tar.gz
	mirror://sourceforge/freepascal/fpc-${PV}.source.tar.gz
	doc? ( mirror://sourceforge/freepascal/Documentation/${PV}/doc-html.tar.gz -> ${P}-doc-html.tar.gz )"

SLOT="0"
LICENSE="GPL-2 LGPL-2.1-with-linking-exception"
KEYWORDS="amd64 x86"
IUSE="doc ide source"
BDEPEND=">=dev-lang/fpc-3 <dev-lang/fpc-3.1"

RDEPEND="ide? ( !dev-lang/fpc-ide )"

DEPEND="${RDEPEND} ${BDEPEND}"

RESTRICT="strip" #269221

S=${WORKDIR}/fpcbuild-${PV}/fpcsrc

pkg_pretend() {
	if [[ ${MERGE_TYPE} != binary ]]; then
		# Bug 475210
		if $(tc-getLD) --version | grep -q "GNU gold"; then
			eerror "fpc does not function correctly when built with the gold linker."
			eerror "Please select the bfd linker with binutils-config."
			die "GNU gold detected"
		fi
	fi
}

src_unpack() {
	case ${ARCH} in
		amd64)	FPC_ARCH="x64" FPC_PARCH="x86_64" PV_BIN=${PV} ;;
		x86)	FPC_ARCH="386" FPC_PARCH="i386" PV_BIN=${PV} ;;
		*)	die "This ebuild doesn't support ${ARCH}." ;;
	esac

	unpack ${A}

}

src_prepare() {
	find "${WORKDIR}" -name Makefile -exec sed -i -e 's/ -Xs / /g' {} + || die

	# let the pkg manager compress man files
	sed -i '/find man.* gzip /d' "${WORKDIR}"/fpcbuild-${PV}/install/man/Makefile || die

	# make the compiled binary check for fpc.cfg under the prefixed /etc/ path
	hprefixify "${WORKDIR}"/fpcbuild-${PV}/fpcsrc/compiler/options.pas
}

src_compile() {

	emake -j1 compiler_cycle AS="$(tc-getAS)"

	# Save new compiler from cleaning...
	cp "${S}"/compiler/ppc${FPC_ARCH} "${S}"/ppc${FPC_ARCH}.new || die

	# ...rebuild with current version...
	emake -j1 PP="${S}"/ppc${FPC_ARCH}.new AS="$(tc-getAS)" compiler_cycle

	# ..and clean up afterwards
	rm "${S}"/ppc${FPC_ARCH}.new || die


	emake -j1 PP="${S}"/compiler/ppc${FPC_ARCH} AS="$(tc-getAS)" rtl_clean

	emake -j1 PP="${S}"/compiler/ppc${FPC_ARCH} rtl packages_all utils

	if use ide ; then
		cd "${S}"/ide || die
		emake -j1 PP="${S}"/compiler/ppc${FPC_ARCH} AS="$(tc-getAS)"
	fi
}

src_install() {
	local pp

	#fpcbuild-3.0.0/utils/fpcm/fpcmake
	#${WORKDIR}/${PN}build-${PV}/utils/fpcm/fpcmake"
	#fpcbuild-3.0.0/fpcsrc/utils/fpcm/bin/x86_64-linux/fpcmake
	set --  FPCMAKE="${S}/utils/fpcm/bin/${FPC_PARCH}-linux/fpcmake" \
		INSTALL_PREFIX="${ED}"/usr \
		INSTALL_DOCDIR="${ED}"/usr/share/doc/${PF} \
		INSTALL_MANDIR="${ED}"/usr/share/man \
		INSTALL_SOURCEDIR="${ED}"/usr/lib/fpc/${PV}/source

	emake -j1 "$@" compiler_install rtl_install packages_install utils_install

	dosym ../lib/fpc/${PV}/ppc${FPC_ARCH} /usr/bin/ppc${FPC_ARCH}

	cd "${S}"/../install/doc || die
	emake -j1 "$@" installdoc

	cd "${S}"/../install/man || die
	emake -j1 "$@" installman

	if use doc ; then
		cd "${S}"/../../doc || die
		dodoc -r *
	fi

	if use ide ; then
		cd "${S}"/ide || die
		emake -j1 "$@" install
	fi

	if use source ; then
		cd "${S}" || die
		shift
		emake -j1 PP="${ED}"/usr/bin/ppc${FPC_ARCH} "$@" sourceinstall
		find "${ED}"/usr/lib/fpc/${PV}/source -name '*.o' -exec rm {} \;
	fi

	"${ED}"/usr/lib/fpc/${PV}/samplecfg "${ED}"/usr/lib/fpc/${PV} "${ED}"/etc || die

	# set correct (prefixed) path for e.g. unit files
	sed -i "s:${ED}:${EPREFIX}:g" "${ED}"/etc/fpc.cfg || die

	if use ide ; then
		sed -e "s:${ED}::g" \
			-i "${ED}"/etc/fppkg.cfg \
			-i "${ED}"/etc/fppkg/* \
			-i "${ED}"/usr/lib/fpc/${PV}/ide/text/fp*.cfg \
			|| die
	fi

	rm -r "${ED}"/usr/lib/fpc/lexyacc || die
}

pkg_postinst() {
	if [[ -z ${REPLACING_VERSIONS} ]] && use ide; then
		einfo "To read the documentation in the fpc IDE, enable the doc USE flag"
	fi
}
