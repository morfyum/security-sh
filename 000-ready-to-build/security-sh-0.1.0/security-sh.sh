#!/usr/bin/env bash

#set -e    # Exit when command exits with a non-zero status (ERROR)
set -u    # Exit when variablie is not defined
#set -x    # Verbose for debugging


### https://www.mankier.com/1/clamscan ###
# Move infected files to a specific directory:
# clamscan --move path/to/quarantine_directory
### ### ### ### ### ###

version="v0.1.0"
selected=""
param1=""

current_date=$(date +'%Y-%m-%d-%r')
current_log="/tmp/clamlog_$current_date.log"

# Pormpt color defines
RED='\033[01;31m'
GREEN='\033[01;32m'
YELLOW='\033[01;33m'
BLUE='\033[01;34m'
NC='\033[0m' # No Color

#terminal="/usr/bin/gnom-terminal"

path_system="/*"
path_home="/home"
path_flatpak="/var/lib/flatpak"

#waitsh="./wait.sh"

function start_personal_terminal() {
	if [ -f "$terminal" ];
    then
	    # Start in new process when possible
	    echo "$terminal exist, use this!"
	    #gnome-terminal --title=$title_bar -- bash -c "$exec_1; $exec_2; $exec_3; $waitsh"
	    gnome-terminal --title=$title_bar -- bash -c "$exec_final; $waitsh"
    else
	    echo "Single process mode"
	    $exec_final
	fi
}


function cat_current_log() {
	sudo cat $current_log |grep 'FOUND' > /dev/null 2>&1
	if [ $? -eq 0 ];
	then
		echo -e "${GREEN}No Infection found $? !${NC}"
	else
		echo -e "${YELLOW}List of Infected files:${NC}"
		sudo cat $current_log |grep "FOUND"
	fi
}

mainmenu() {
echo -ne "${BLUE}────────────────────────────── ──────────────────────────────
[ SECURITY.SH ] [ $version ]
────────────────────────────── ──────────────────────────────
[ 00 ]: Exit ( Ctrl+C )        [ 06 ]: -
[ 01 ]: Update Database        [ 07 ]: -
[ 02 ]: Check File/Folder      [ 08 ]: -
[ 03 ]: Check SYSTEM           [ 09 ]: -
[ 04 ]: Check HOME             [ 10 ]: -
[ 05 ]: Remove clam logs       [ 11 ]: -
────────────────────────────── ──────────────────────────────${NC}
${GREEN}$SHELL: $selected $param1 ${NC}
Choose an option:  "
    read -r answer
    case $answer in

    0 | 00 | exit | q)
        selected="Exit, Bye!"
		echo $selected
        exit 0
        ;;

    1 | 01)
		selected="freshclam  # Update ClamAV database"
		clear
		
		freshclam
        
		mainmenu
        ;;

    2 | 02)
        selected="Check File/Folder:"
		clear
		echo "Type path your file:"
		read -e -p "Check file or filder: " param1
		clear

		#title_bar="Scanning"
		#exec_1="sudo clamscan --recursive $param1 --log=$current_log"
		#exec_2="echo -e \"${RED} **** [ $current_log ] ****${NC}\""
		#exec_3="sudo cat $current_log |grep 'FOUND'"
		#exec_final="$exec_1 && $exec_3"
		#start_personal_terminal

		echo -e "Check [${GREEN} $param1 ${NC}]"
		clamscan --recursive $param1 --log=$current_log
		echo -e "${RED} **** [ $current_log ] ****${NC}"
		sudo cat $current_log |grep "FOUND"
		
		mainmenu
		param1=""
        ;;

    3 | 03)
		selected="Check SYSTEM except $path_home, $path_flatpak"
		clear
		
		# DO SOMETHING
		echo -e "Check [ ${GREEN}$path_system${NC} ] except: [ ${RED}$path_home/*${NC} ], [ ${RED}$path_flatpak/*${NC} ]"
		clamscan --recursive $path_system --exclude-dir="$path_home/*" --exclude-dir="$path_flatpak/*" --log=$current_log
		echo -e "${RED} **** [ $current_log ] ****${NC}"
		sudo cat $current_log |grep "FOUND"

        mainmenu
        ;;

    4 | 04)
		selected="Check $HOME"
		clear

		# DO SOMETHING
		echo -e "Check ${GREEN}$HOME/*${NC}"
		clamscan --recursive $HOME/* --log=$current_log
		echo -e "${RED} **** [ $current_log ] ****${NC}"
		cat $current_log |grep "FOUND"
        
		mainmenu
        ;;

    5 | 05)
		selected="Remove log files /tmp/clamlog*.log"
		param1=''
		clear
		
		# DO SOMETHING
		echo "Remove log files..."
		rm --verbose /tmp/clamlog*.log
        
		mainmenu
        ;;

    6 | 06)
		selected="-"
		clear
		
		# DO SOMETHING
		echo "Empty row $param1, do nothing"
        
		mainmenu
        ;;

    7 | 07)
		selected=""
		clear
		
		# DO SOMETHING
		echo "Do nothing"
        
		mainmenu
        ;;

    8 | 08)
		selected="-"
		clear

		# DO SOMETHING
        
		mainmenu
        ;;

    9 | 09)
		selected="-"
		clear

		# DO SOMETHING
        
		mainmenu
        ;;

    10)
		selected="-"
		clear

		# DO SOMETHING
        
		mainmenu
        ;;

    11)
		selected="-"
		clear

		# DO SOMETHING
		echo "Do nothing"
        
		mainmenu
        ;;

    *)
        selected="Unknown option."
        clear
		mainmenu
        ;;
    esac
}


# START THE APPLICATION

# Ensure running as root
if [ "$(id -u)" != "0" ]; then
    exec sudo "$0" "$@"
fi

clear
mainmenu
#param1=''

