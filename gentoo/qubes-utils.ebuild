# Maintainer: Frédéric Pierret <frederic.pierret@qubes-os.org>

EAPI=6

inherit git-r3 eutils multilib

MY_PV=${PV/_/-}
MY_P=${PN}-${MY_PV}

KEYWORDS="amd64"
EGIT_REPO_URI="https://github.com/QubesOS/qubes-linux-utils.git"
EGIT_COMMIT="v${PV}"
DESCRIPTION="Common Linux files for Qubes VM"
HOMEPAGE="http://www.qubes-os.org"
LICENSE="GPLv2"

SLOT="0"
IUSE=""

DEPEND="media-gfx/imagemagick \
        dev-python/pycairo \
        dev-python/pillow \
        dev-python/numpy \
        app-emulation/qubes-libvchan-xen \
        "
RDEPEND=""
PDEPEND=""

src_prepare() {
    einfo "Apply patch set"
    EPATCH_SUFFIX="patch" \
    EPATCH_FORCE="yes" \
    EPATCH_OPTS="-p1" \
    epatch "${FILESDIR}"

    default
}

src_compile() {
    myopt="${myopt} DESTDIR="${D}" BACKEND_VMM=xen LIBDIR=/usr/$(get_libdir)"
    emake ${myopt} all
}

src_install() {
    emake ${myopt} install
}
