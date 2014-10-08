require "formula"

class Kalendas < Formula
  homepage "https://github.com/mikemolina/kalendas"
  url "https://launchpad.net/kalendas/trunk/1.0.2/+download/kalendas-1.0.2.tar.gz"
  sha1 "3f714dea45621d795eebf0c8253d28c8dd6e6582"
  head do
    url "https://github.com/mikemolina/kalendas.git"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "gettext" => :build
    depends_on "texinfo" => :build
  end

  option "enable-charset-latin1", "Build with charset latin1"

  depends_on "Locale::TextDomain" => :perl
  depends_on "gettext" if build.include? "enable-charset-latin1"
  depends_on "texinfo" if build.include? "enable-charset-latin1"

  def install
    system "./autogen.sh" if build.head?

    args = %W[
      --disable-dependency-tracking
      --disable-silent-rules
      --prefix=#{prefix}
    ]

    args << "--enable-charset=latin1" if build.include? "enable-charset-latin1"

    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/kalendas"
  end
end
