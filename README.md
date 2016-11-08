# League-Of-Legends
Linux: League Of Legends www.leagueoflegends.com install/run wrapper

Tested: Archlinux 08.11.2016 wine-staging 1.9.21

# Instructions
Fresh install:

- Install scripts by install.sh/package.sh
- Change config if you need /etc/leagueoflegends.conf
- Run "leagueoflegends" in console or run desktop application "League of Legends"

If you want move from previous LoL installation:

- Make steps like for fresh installation
- Wait until installation of LoL started, ignore installation window
- Copy/Move your LoL client dir to WINEPREFIX (see conf)
- Cancel installation
- If launcher don't start automaticaly, run script/desktop app again

By this you do the trick and script will think what lol has been installed

# Know problems

Black Login Screen:
- Workaround - Not found
- Try change random winecfg settings until it's fixed, after return it to default and all works good (example try run with virtualdesktop), if someone know solution let me know.
