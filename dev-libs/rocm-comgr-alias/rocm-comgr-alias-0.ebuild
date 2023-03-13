EAPI=7
SLOT=0

KEYWORDS=amd64

S="${WORKDIR}"

src_install()
{
     mkdir -p "${ED}"/usr/include/amd_comgr
     ln -s /usr/include/amd_comgr.h "${ED}"/usr/include/amd_comgr
}