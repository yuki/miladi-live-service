pkgname='miladi-live-service'
pkgver=20241001
pkgrel=1
pkgdesc="Miladi Linux live session"
arch=('any')
url="https://github.com/yuki/miladi-live-service.git"
license=('GPL-3.0-or-later')
makedepends=('git')
provides=("${pkgname}")
options=(!strip !emptydirs)
source=("git+file://${PWD}")
sha256sums=('SKIP')

package() {
    InternalDir="${srcdir}/${pkgname}"

    # Copy files
    if [ -d "${InternalDir}/usr" ]; then
        cp -r "${InternalDir}/usr" "${pkgdir}/"
    fi

    if [ -d "${InternalDir}/etc" ]; then
        cp -r "${InternalDir}/etc" "${pkgdir}/"
    fi

    if [ -d "${InternalDir}/lib" ]; then
        cp -r "${InternalDir}/lib" "${pkgdir}/"
    fi
}
