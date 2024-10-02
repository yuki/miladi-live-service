pkgname='miladi-live-service'
pkgver=20241002
pkgrel=2
pkgdesc="Miladi Linux live session"
arch=('any')
url="https://github.com/yuki/miladi-live-service.git"
license=('GPL-3.0-or-later')
makedepends=('git')
provides=("${pkgname}")
options=(!strip !emptydirs)
source=("git+file://${PWD}")
sha256sums=('SKIP')
install=$pkgname.install

package() {
    InternalDir="${srcdir}/${pkgname}"

    # Copy files
    if [ -d "${InternalDir}/usr" ]; then
        cp -r "${InternalDir}/usr" "${pkgdir}/"
    fi
}