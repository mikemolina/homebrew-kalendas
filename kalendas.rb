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

  depends_on "perl"

  resource "Locale::TextDomain" do
    url "https://cpan.metacpan.org/authors/id/G/GU/GUIDO/libintl-perl-1.29.tar.gz"
    sha256 "78935f10db6d6a080c3160b4ae02c3f6ed07ef6bf624623295a87545e0cbfbb1"
  end

  depends_on "gettext" if build.include? "charset-latin1"
  depends_on "texinfo" if build.include? "charset-latin1"

  def install
    # This ensures that the Locale::TextDomain module is installed
    # inside brew, according to homebrew changes 1.5.0. See
    # https://brew.sh/2018/01/19/homebrew-1.5.0/
    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"

    resources = [
      "Locale::TextDomain",
    ]

    resources.each do |r|
      resource(r).stage do
        system "perl", "Makefile.PL", "INSTALL_BASE=#{libexec}"
        system "make", "install"
      end
    end

    system "./autogen.sh" if build.head?

    args = %W[
      --disable-dependency-tracking
      --disable-silent-rules
      --prefix=#{libexec}
      --with-bash-completion==#{etc}/bash_completion.d
    ]

    args << "--enable-charset=latin1" if build.include? "charset-latin1"

    system "./configure", *args
    system "make"
    system "make", "install"

    bin.install libexec/"bin/kalendas"
    bin.env_script_all_files(libexec/"bin", :PERL5LIB => ENV["PERL5LIB"])
    man1.install libexec/"share/man/man1/kalendas.1"
    info.install libexec/"share/info/kalendas.info"

    bash_completion.install "extra/kalendas-bash-completion.sh" => "kalendas-bash-completion.sh"
  end

  def caveats; <<~EOS
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
