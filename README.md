Install kalendas with Homebrew
==============================

For install **kalendas** with [Homebrew](http://brew.sh/) or [Linuxbrew](http://brew.sh/linuxbrew/) add the repository

    $ brew tap mikemolina/kalendas
and then

    $ brew install kalendas
Verify the installation

    $ brew test kalendas
You can also install the version under development

    $ brew install --HEAD kalendas
This option requires the dependencies autoconf, automake, gettext, texinfo and
optionaly LaTeX and pkg-config. To build the program with latin characters use
the option '--enable-charset-latin1'.

Uninstall
---------
    $ brew remove kalendas
