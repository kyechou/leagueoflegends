PREFIX ?= /

SRC_DIR := $(dir $(lastword $(MAKEFILE_LIST)))

CFG_S := $(SRC_DIR)/leagueoflegends.conf
BIN_S := $(SRC_DIR)/leagueoflegends
DSK_S := $(SRC_DIR)/leagueoflegends.desktop
PNG_S := $(SRC_DIR)/leagueoflegends.png

CFG_D := $(PREFIX)/etc/leagueoflegends.conf
BIN_D := $(PREFIX)/usr/bin/leagueoflegends
DSK_D := $(PREFIX)/usr/share/applications/leagueoflegends.desktop
PNG_D := $(PREFIX)/usr/share/icons/hicolor/256x256/apps/leagueoflegends.png


default:  help


$(CFG_D): $(CFG_S)
	install -Dm644 $< $@

$(BIN_D): $(BIN_S)
	install -Dm755 $< $@

$(DSK_D): $(DSK_S)
	install -Dm644 $< $@

$(PNG_D): $(PNG_S)
	install -Dm644 $< $@

install: ## Install leagueoflegends wine
install: $(CFG_D) $(BIN_D) $(DSK_D) $(PNG_D)

uninstall: ## Delete leagueoflegends wine
uninstall:
	@rm -fv $(CFG_D) $(BIN_D) $(DSK_D) $(PNG_D)


deb: ## Create debian package
deb:
	./package.sh debian

help: ## Show help
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##/\t/'
