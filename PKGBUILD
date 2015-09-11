pkgname=epi3lock
pkgver=2.7
pkgrel=1
pkgdesc="An improved screenlocker based upon XCB and PAM for EPITA"
arch=('i686' 'x86_64')
url="http://i3wm.org/i3lock/"
license=('MIT')
groups=("i3")
depends=('xcb-util-image' 'libev' 'cairo' 'libxkbcommon-x11')
backup=("etc/pam.d/i3lock")
source=("http://i3wm.org/i3lock/$pkgname-$pkgver.tar.bz2"
        "http://i3wm.org/i3lock/$pkgname-$pkgver.tar.bz2.asc")
md5sums=('a17ab7611e0d6bcf568fb6c4d7f65434' 'SKIP')
validpgpkeys=('424E14D703E7C6D43D9D6F364E7160ED4AC8EE1D') # Michael Stapelberg

build() {
  cd "${srcdir}/${pkgname}-${pkgver}"
  
  # Fix ticket FS#31544, sed line taken from gentoo
  sed -i -e 's:login:system-auth:' epi3lock.pam

  make
}

package() {
  cd "${srcdir}"
  make DESTDIR="${pkgdir}" install
  
  make clean
}

# vim:set ts=2 sw=2 et:
