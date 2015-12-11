========
dotfiles
========

Quickstart
==========

dotfiles
--------

.. code-block:: console

   $ git clone git@github.com:jptomo/dotfiles.git
   $ cd dotfiles
   $ bash setup.sh

mlterm
------

build on Fedora 23

.. code-block:: console

   $ sudo dnf install libXt-devel cairo-devel gdk-pixbuf2-devel
   $ curl -O http://netix.dl.sourceforge.net/project/mlterm/01release/mlterm-3.6.0/mlterm-3.6.0.tar.gz
   $ tar xf mlterm-3.6.0.tar.gz
   $ cd mlterm-3.6.0
   $ ./configure \
   > --prefix=/opt/mlterm/3.6.0 \
   > --enable-fcitx \
   > --enable-optimize-redrawing \
   > --with-gtk=3.0 \
   > --with-type-engines=cairo \
   > --with-scrollbars=sample,extra,pixmap_engine
   $ make
   $ sudo mkdir -p /opt/mlterm/3.6.0
   $ sudo make install

setup

.. code-block:: console

   $ git clone git@github.com:jptomo/dotfiles.git
   $ cd dotfiles
   $ sudo cp misc/mlterm.desktop /usr/share/applications/
   $ cp -r misc/mlterm ~/.mlterm

Directories
===========

::

  .
  ├── ansible:  build up work space of fedora
  ├── dots:     dotfiles
  ├── misc
  │   ├── Vagrant:        Vagrant of fedora
  │   ├── brew-Formulas:  homebrew fomulas
  │   ├── emacs:          emacs setup files
  │   └── mlterm:         mlterm config files
  └── msys2:    Msys2 build script
