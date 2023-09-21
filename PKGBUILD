# Maintainer: SidGames5 <sidgamessendmestuff@gmail.com>
pkgname='autobuild'
pkgver='1.0.0'
pkgrel=1
epoch=
pkgdesc="Easily package your software for different operating systems, architectures, and package managers."
arch=('x86_64')
url="https://github.com/sidgames5/autobuild"
license=('GPL-3')
makedepends=('haxe')
provides=('autobuild')
source=("$url/archive/refs/tags/$pkgver.tar.gz")
md5sums=('SKIP')

build() {
	cd "$pkgname-$pkgver"
	haxe build.hxml
}

package() {
	cd "$pkgname-$pkgver"
	install -Dm755 ./bin/builder/Main "$pkgdir/usr/bin/build"
	install -Dm755 ./bin/tester/Main "$pkgdir/usr/bin/atest"
}
