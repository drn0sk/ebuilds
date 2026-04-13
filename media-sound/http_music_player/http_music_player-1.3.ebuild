# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="An http server that serves audio files and an html/js music player."
HOMEPAGE="https://github.com/drn0sk/http_music_player"
SRC_URI="https://github.com/drn0sk/http_music_player/archive/refs/tags/v${PV}.tar.gz -> ${PF}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=">=net-libs/http_lib-2.0:=[server,shared-libs]"
RDEPEND="${DEPEND}"

src_compile () {
	emake DESTDIR="" prefix="/usr" localstatedir="/var" BUILD_DIR="$S"
}

src_install () {
	emake DESTDIR="${D}" prefix="/usr" localstatedir="/var" BUILD_DIR="$S" install
	newinitd "${FILESDIR}"/http_music_player.initd http_music_player
	newconfd "${FILESDIR}"/http_music_player.confd http_music_player
}
