# Copyright
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Implementation of a subset of LAPACK functionality on the ROCm platform"
HOMEPAGE="https://github.com/ROCmSoftwarePlatform/rocSOLVER"
SRC_URI="https://github.com/ROCmSoftwarePlatform/rocSOLVER/archive/rocm-${PV}.tar.gz -> rocSOLVER-${PV}.tar.gz"

LICENSE="BSD-2"
KEYWORDS="amd64"
SLOT="0"

PATCHES=( "${FILESDIR}/rocSOLVER-4.3.0-add-stdint.patch" )

IUSE="+gfx803 gfx900 gfx906 gfx908"
REQUIRED_USE="|| ( gfx803 gfx900 gfx906 gfx908 )"

RDEPEND=">=dev-util/hip-${PV}
	 >=sci-libs/rocBLAS-${PV}"
DEPEND="${RDEPEND}
	dev-util/cmake
	>=dev-util/ninja-1.9.0"

S=${WORKDIR}/${PN}-rocm-${PV}

src_prepare() {
	sed -e "s: PREFIX rocsolver:# PREFIX rocsolver:" -i rocsolver/library/src/CMakeLists.txt
	sed -e "s:\$<INSTALL_INTERFACE\:include>:\$<INSTALL_INTERFACE\:include/rocsolver>:" -i rocsolver/library/src/CMakeLists.txt
	sed -e "s:rocm_install_symlink_subdir( rocsolver ):#rocm_install_symlink_subdir( rocsolver ):" -i rocsolver/library/src/CMakeLists.txt

	cmake_src_prepare
}

src_configure() {
        # Grant access to the device
        addwrite /dev/kfd
        addpredict /dev/dri/

	# Compiler to use
	CXX="/usr/lib/hip/bin/hipcc"

	# Target to use
	AMDGPU_TARGETS=""
        if use gfx803; then
		AMDGPU_TARGETS+="gfx803;"
        fi
        if use gfx900; then
		AMDGPU_TARGETS+="gfx900;"
        fi
        if use gfx906; then
		AMDGPU_TARGETS+="gfx906;"
        fi
        if use gfx908; then
		AMDGPU_TARGETS+="gfx908;"
        fi

	local mycmakeargs=(
		-Wno-dev
		-DAMDGPU_TARGETS="${AMDGPU_TARGETS}"
		-DCMAKE_CXX_FLAGS="--rocm-path=/usr"
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr/"
		-DCMAKE_INSTALL_INCLUDEDIR="${EPREFIX}/usr/include/rocsolver"
		-DBUILD_CLIENTS_SAMPLES=NO
		-DBUILD_CLIENTS_TESTS=NO
		-DBUILD_CLIENTS_BENCHMARKS=NO
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install
	chrpath --delete "${D}/usr/lib64/librocsolver.so.0.1"
	rm -R ${D}/usr/usr
	mkdir ${D}/usr/include
	ln -s ../rocsolver/usr/include/rocsolver ${D}/usr/include
}
