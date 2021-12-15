#
# Makefile for installing/packaging leagueoflegends helper program
#

pkgname     := leagueoflegends

PREFIX		?= /usr
prefix      := $(DESTDIR)$(PREFIX)
bindir      := $(prefix)/bin
datarootdir := $(prefix)/share
docdir      := $(datarootdir)/doc/$(pkgname)
iconsdir    := $(datarootdir)/icons
licensesdir := $(datarootdir)/licenses/$(pkgname)
bashcompdir := $(datarootdir)/bash-completion/completions


nop:

install:
	install -Dm755 leagueoflegends          -t $(bindir)
	install -Dm644 leagueoflegends.desktop  -t $(datarootdir)/applications
	install -Dm644 leagueoflegends.png      -t $(iconsdir)/hicolor/256x256/apps
	install -Dm644 leagueoflegends.reg      -t $(docdir)
	install -Dm644 LICENSE                  -t $(licensesdir)
	install -Dm644 completion.bash             $(bashcompdir)/$(pkgname)

uninstall:
	@rm -vf $(bindir)/leagueoflegends
	@rm -vf $(datarootdir)/applications/leagueoflegends.desktop
	@rm -vf $(iconsdir)/hicolor/256x256/apps/leagueoflegends.png
	@rm -vf $(docdir)/leagueoflegends.reg
	@rm -vf $(licensesdir)/LICENSE
	@rm -vf $(bashcompdir)/$(pkgname)

deb: ## Create debian package
	./package.sh debian

.PHONY: nop install uninstall deb
