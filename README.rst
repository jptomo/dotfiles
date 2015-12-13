========
dotfiles
========

Quickstart
==========

dotfiles
--------

.. code-block:: console

   $ bash setup.sh

ansible
-------

.. code-block:: console

   $ sudo dnf install ansible python-dnf
   $ ansible-playbook ansible/playbook_all.yml -i ansible/hosts -t setup -K
   $ ansible-playbook ansible/playbook_all.yml -i ansible/hosts -t vim,python2,python3,ocaml -K

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

   $ cp -r misc/mlterm ~/.mlterm
   $ export PATH="/opt/mlterm/3.6.0/bin:$PATH"
   $ sudo cp misc/mlterm.desktop /usr/share/applications/
   $ cat > ~/.manpath
   MANDATORY_MANPATH /opt/mlterm/3.6.0/share/man
   MANPATH_MAP  /opt/mlterm/3.6.0/bin /opt/mlterm/3.6.0/share/man
   MANDB_MAP /opt/mlterm/3.6.0/share/man /var/cache/man/opt/mlterm

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
