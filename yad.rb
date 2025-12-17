class Yad < Formula
  desc "Yet Another Dialog, a fork of Zenity: GTK+ dialog boxes for the CLI"
  homepage "https://github.com/v1cont/yad.git"
  url "https://github.com/v1cont/yad/archive/refs/tags/v14.2.tar.gz"
  sha256 "6748c0ecb917043326cc70646f143890151dea2fc50db5fe54439de6dc04b1e3"

  head do
    url "https://github.com/v1cont/yad.git"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "gettext" => :build
  depends_on "itstool" => :build
  depends_on "jcudit/webkitgtk/webkitgtk" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "gtk+3"

  def install
    #ENV.prepend_path "PKG_CONFIG_PATH", "/opt/X11/lib/pkgconfig"
    gettextize = "#{Formula["gettext"].bin}/gettextize"
    system "script", "-q", "/dev/null", gettextize.to_s
    #inreplace "configure.ac", "AC_CONFIG_FILES([ po/Makefile.in", "AC_CONFIG_FILES(["
    system "autoreconf", "-ivf"
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}",
                          "--with-gtk=gtk3"
    inreplace "Makefile", "SUBDIRS = src po data", "SUBDIRS = src data"
    system "make", "install"
  end

  test do
    system "#{bin}/yad", "--help"
  end
end
