# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="An http client/server library"
HOMEPAGE="https://github.com/drn0sk/http_lib"

if [[ "${PV}" == 9999 ]] ; then
	EGIT_REPO_URI="https://github.com/drn0sk/http_lib.git"
	inherit git-r3
else
	SRC_URI="https://github.com/drn0sk/http_lib/archive/refs/tags/v${PV}.tar.gz -> ${PF}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0/2"
IUSE="+client +server +shared-libs static-libs"
REQUIRED_USE="
	|| ( client server )
	|| ( shared-libs static-libs )
"

src_configure() {
	export STATIC= SHARED= CLIENT= SERVER=
	use static-libs && export STATIC=1
	use shared-libs && export SHARED=1
	use server && export SERVER=1
	use client && export CLIENT=1
}

src_compile() {
	emake STATIC="$STATIC" SHARED="$SHARED" CLIENT="$CLIENT" SERVER="$SERVER" BUILD_DIR="$S"
}

src_install() {
	emake STATIC="$STATIC" SHARED="$SHARED" CLIENT="$CLIENT" SERVER="$SERVER" \
		DESTDIR="${D}" prefix="/usr" libdir="\$(exec_prefix)/$(get_libdir)" BUILD_DIR="$S" install
}
