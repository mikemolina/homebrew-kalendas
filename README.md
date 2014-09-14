Install kalendas with Homebrew
==============================

For install **kalendas** with *Homebrew* or *Linuxbrew* add the repository

    $ brew tap mikemolina/kalendas
and then

    $ brew install kalendas
Verify the installation

    $ brew test kalendas
You can also install the version under development

    $ brew install --HEAD kalendas
This option requires the dependencies autoconf, automake, gettext and texinfo.
To build the program with latin characters use the option '--enable-charset-latin1'.

Uninstall
---------
    $ brew remove kalendas
