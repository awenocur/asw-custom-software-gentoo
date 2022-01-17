# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake flag-o-matic prefix

if [[ ${PV} == *9999 ]] ; then
	EGIT_REPO_URI="https://github.com/RadeonOpenCompute/ROCm-OpenCL-Runtime/"
	inherit git-r3
else
	SRC_URI="https://github.com/RadeonOpenCompute/ROCm-OpenCL-Runtime/archive/roc-${PV}.tar.gz -> ${P}.tar.gz
		https://github.com/ROCm-Developer-Tools/ROCclr/archive/rocm-${PV}.tar.gz -> rocclr-${PV}.tar.gz"
	KEYWORDS="amd64"
	S="${WORKDIR}/ROCm-OpenCL-Runtime-rocm-${PV}"
fi

DESCRIPTION="Radeon Open Compute OpenCL Compatible Runtime"
HOMEPAGE="https://github.com/RadeonOpenCompute/ROCm-OpenCL-Runtime"

LICENSE="Apache-2.0 MIT"
SLOT="0/$(ver_cut 1-2)"

RDEPEND=">=dev-libs/rocr-runtime-${PV}
	>=dev-libs/rocm-comgr-${PV}
	>=dev-libs/rocm-device-libs-${PV}
	>=virtual/opencl-3
	media-libs/mesa"
DEPEND="${RDEPEND}
	dev-ml/findlib"
BDEPEND=">=dev-util/rocm-cmake-${PV}"

PATCHES=(
	"${FILESDIR}/${PN}-4.5.2-change-install-location.patch"
	"${FILESDIR}/${PN}-3.5.0-do-not-install-libopencl.patch"
)

src_prepare() {
	# Remove "clinfo" - use "dev-util/clinfo" instead
	[ -d tools/clinfo ] && rm -rf tools/clinfo || die

	cmake_src_prepare

	hprefixify amdocl/CMakeLists.txt
}

src_configure() {
	# Reported upstream: https://github.com/RadeonOpenCompute/ROCm-OpenCL-Runtime/issues/120
	append-cflags -fcommon

	local mycmakeargs=(
		-DROCCLR_PATH="${WORKDIR}/ROCclr-rocm-${PV}"
		-DAMD_OPENCL_PATH="${S}"
	)
	cmake_src_configure
}

src_install() {
	mkdir -p ${ED}/usr/lib64 ${ED}/etc/OpenCL/vendors
	cp ${BUILD_DIR}/amdocl/libamdocl64.so ${ED}/etc/OpenCL/vendors/amdocl64.icd
	echo libamdocl64.so >  ${ED}/usr/lib64/libamdocl64.so
}
