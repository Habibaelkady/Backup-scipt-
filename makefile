$(shell mkdir -p backup)
all:
	./backupd.sh main backup 2 2
