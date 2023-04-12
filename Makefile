#
# Makefile for installing/packaging leagueoflegends helper program
#

pkgname     := leagueoflegends

PREFIX      ?= /usr
prefix      := $(DESTDIR)$(PREFIX)
bindir      := $(prefix)/bin
datarootdir := $(prefix)/share
docdir      := $(datarootdir)/doc/$(pkgname)
iconsdir    := $(datarootdir)/icons
licensesdir := $(datarootdir)/licenses/$(pkgname)
bashcompdir := $(datarootdir)/bash-completion/completions
zshcompdir  := $(datarootdir)/zsh/site-functions
fishcompdir := $(datarootdir)/fish/vendor-completions.d

nop:

install:
	install -Dm755 leagueoflegends          -t $(bindir)
	install -Dm644 leagueoflegends.desktop  -t $(datarootdir)/applications
	install -Dm644 riot.desktop             -t $(datarootdir)/applications
	install -Dm644 leagueoflegends.png      -t $(iconsdir)/hicolor/256x256/apps
	install -Dm644 riot.svg                 -t $(iconsdir)/hicolor/scalable/apps
	install -Dm644 leagueoflegends.reg      -t $(docdir)
	install -Dm644 LICENSE                  -t $(licensesdir)
	install -Dm644 completion.bash             $(bashcompdir)/$(pkgname)
	install -Dm644 completion.zsh              $(zshcompdir)/_$(pkgname)
	install -Dm644 completion.fish        	   $(fishcompdir)/$(pkgname).fish

uninstall:
	@rm -vf $(bindir)/leagueoflegends
	@rm -vf $(datarootdir)/applications/leagueoflegends.desktop
	@rm -vf $(datarootdir)/applications/riot.desktop
	@rm -vf $(iconsdir)/hicolor/256x256/apps/leagueoflegends.png
	@rm -vf $(iconsdir)/hicolor/scalable/apps/riot.svg
	@rm -vf $(docdir)/leagueoflegends.reg
	@rm -vf $(licensesdir)/LICENSE
	@rm -vf $(bashcompdir)/$(pkgname)
	@rm -vf $(zshcompdir)/_$(pkgname)
	@rm -vf $(fishcompdir)/$(pkgname).fish

.PHONY: nop install uninstall
