require "formula"

class Kalendas < Formula
  homepage "https://github.com/mikemolina/kalendas"
  url "https://launchpad.net/kalendas/trunk/1.0.0/+download/kalendas-1.0.0.tar.gz"
  sha1 "94879eb4e1537cfb0899a074764c7caca91f1514"

  # gettext, Dependencia en duda?
  # depends_on "gettext"
  depends_on "Locale::TextDomain" => :perl

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end
end
