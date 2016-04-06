class Kalendas < Formula
  desc "Calculations of Calendar and Julian Date"
  homepage "https://mikemolina.github.io/kalendas-home"
  url "https://launchpad.net/kalendas/trunk/1.3.0/+download/kalendas-1.3.0.tar.gz"
  sha256 "eb6f8b3ef4cfe86df461a3899a3a0d6393d487e425e0a010187ef1a7dc46fa32"

  head do
    url "https://github.com/mikemolina/kalendas.git"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "gettext" => :build
    depends_on "texinfo" => :build
  end

  option "with-charset-latin1", "Build with charset latin1"

  depends_on "Locale::TextDomain" => :perl
  depends_on "gettext" if build.include? "charset-latin1"
  depends_on "texinfo" if build.include? "charset-latin1"

  def install
    system "./autogen.sh" if build.head?

    args = %W[
      --disable-dependency-tracking
      --disable-silent-rules
      --prefix=#{prefix}
      --with-bash-completion==#{etc}/bash_completion.d
    ]

    args << "--enable-charset=latin1" if build.include? "charset-latin1"

    system "./configure", *args
    system "make"
    system "make", "install"

    bash_completion.install "extra/kalendas-bash-completion.sh" => "kalendas-bash-completion.sh"
  end

  def caveats; <<-EOS.undent
    Add the following lines to your ~/.bash_profile or ~/.bashrc:
    # Bash completion for kalendas
    if [ -d $(brew --prefix)/etc/bash_completion.d ]; then
       . $(brew --prefix)/etc/bash_completion.d/kalendas-bash-completion.sh
    fi
    EOS
  end

  test do
    system "#{bin}/kalendas"
  end
end
