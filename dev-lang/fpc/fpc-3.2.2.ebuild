# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit prefix toolchain-funcs

HOMEPAGE="https://www.freepascal.org/"
DESCRIPTION="Free Pascal Compiler"
SRC_URI="mirror://sourceforge/freepascal/fpcbuild-${PV}.tar.gz
	mirror://sourceforge/freepascal/fpc-${PV}.source.tar.gz
	doc? ( mirror://sourceforge/freepascal/Documentation/${PV}/doc-html.tar.gz -> ${P}-doc-html.tar.gz )"
S="${WORKDIR}/fpcbuild-${PV}/fpcsrc"

LICENSE="GPL-2 LGPL-2.1-with-linking-exception"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="doc source"
RESTRICT="strip" #269221
BDEPEND=">=dev-lang/fpc-3"

# fpc is special: it can't use CFLAGS and LDFLAGS directly
# since those are geared for running through gcc's frontend
QA_FLAGS_IGNORED="
	usr/bin/.*
	usr/lib.*/.*"

pkg_pretend() {
	if [[ ${MERGE_TYPE} != binary ]]; then
		# Bug 475210
		if $(tc-getLD) --version | grep -q "GNU gold"; then
			eerror "fpc has several issues with the gold linker and does not easily"
			eerror "permit selection. Please do not use USE=default-gold on binutils."
			die "GNU gold detected from $(tc-getLD)"
		fi
	fi
}

src_unpack() {
	case ${ARCH} in
		amd64)
			FPC_ARCH="x64"
			FPC_PARCH="x86_64"
			PV_BIN="${PV}"
			;;
		x86)
			FPC_ARCH="386"
			FPC_PARCH="i386"
			PV_BIN="${PV}"
			;;
		*)
			die "This ebuild doesn't support ${ARCH}" ;;
	esac

	unpack ${A}

}

src_prepare() {
	default

	find "${WORKDIR}" -name Makefile -exec sed -i 's/ -Xs / /' {} + || die

	# let the pkg manager compress man files
	sed -i '/find man.* gzip /d' "${WORKDIR}"/fpcbuild-${PV}/install/man/Makefile || die

	# make the compiled binary check for fpc.cfg under the prefixed /etc/ path
	hprefixify "${WORKDIR}"/fpcbuild-${PV}/fpcsrc/compiler/options.pas
}

src_compile() {

	emake compiler_cycle AS="$(tc-getAS)"

	# Save new compiler from cleaning...
	cp compiler/ppc${FPC_ARCH} ppc${FPC_ARCH}.new || die

	# ...rebuild with current version...
	emake PP="${S}/ppc${FPC_ARCH}.new" AS="$(tc-getAS)" compiler_cycle

	# ..and clean up afterwards
	rm ppc${FPC_ARCH}.new || die

	emake PP="${S}/compiler/ppc${FPC_ARCH}" AS="$(tc-getAS)" rtl_clean

	# ide is moved to packages directory and build unconditionally
	emake PP="${S}/compiler/ppc${FPC_ARCH}" AS="$(tc-getAS)" rtl packages_all utils
}

src_install() {

	#fpcbuild-3.0.0/utils/fpcm/fpcmake
	#${WORKDIR}/${PN}build-${PV}/utils/fpcm/fpcmake"
	#fpcbuild-3.0.0/fpcsrc/utils/fpcm/bin/x86_64-linux/fpcmake
	set -- PP="${S}/compiler/ppc${FPC_ARCH}" FPCMAKE="${S}/utils/fpcm/bin/${FPC_PARCH}-linux/fpcmake" \
		INSTALL_PREFIX="${ED}"/usr \
		INSTALL_DOCDIR="${ED}"/usr/share/doc/${PF} \
		INSTALL_MANDIR="${ED}"/usr/share/man \
		INSTALL_SOURCEDIR="${ED}"/usr/lib/fpc/${PV}/source

	emake "$@" compiler_install rtl_install packages_install utils_install

	dosym ../lib/fpc/${PV}/ppc${FPC_ARCH} /usr/bin/ppc${FPC_ARCH}

	emake -C "${S}"/../install/doc "$@" installdoc
	emake -C "${S}"/../install/man "$@" installman

	use doc && dodoc -r "${S}"/../../doc/.

	if use source ; then
		shift
		emake PP="${ED}"/usr/bin/ppc${FPC_ARCH} "$@" sourceinstall
		find "${ED}"/usr/lib/fpc/${PV}/source -name '*.o' -delete || die
	fi

	"${ED}"/usr/lib/fpc/${PV}/samplecfg "${ED}"/usr/lib/fpc/${PV} "${ED}"/etc || die

	# set correct (prefixed) path for e.g. unit files
	sed -i "s:${ED}:${EPREFIX}:g" "${ED}"/etc/fpc.cfg || die

	sed -e "s:${ED}::g" \
		-i "${ED}"/etc/fppkg.cfg \
		-i "${ED}"/etc/fppkg/default \
		-i "${ED}"/usr/lib/fpc/${PV}/ide/text/fp.cfg \
		|| die

	rm -r "${ED}"/usr/lib/fpc/lexyacc || die

	case ${ARCH} in
		amd64)
			mkdir -p "${ED}"/usr/$(get_libdir) || die
			mv "${ED}"/usr/lib/*.so "${ED}/usr/$(get_libdir)/" || die
			;;
	esac
}

pkg_postinst() {
	if [[ -z ${REPLACING_VERSIONS} ]] && ! use doc; then
		elog "To read the documentation in the fpc IDE, enable the doc USE flag"
	fi
}
