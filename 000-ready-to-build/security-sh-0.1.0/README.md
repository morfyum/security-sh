security.sh is a Command Line interface for ClamAV

Developer: Morfyum
mail: morfyum@gmail.com
gitHub: github.com/morfyum

-------                      ------------      -------------
OPTION:                      KEY:              DESCRIPTION
-------                      ------------      -------------
[ 00 ] Exit:                 Ctrl+C, q, 0      Exit form application
[ 01 ] Update Database       1, 01             Run: `freshclam` command, and update ClamAV virus definiton databse
[ 02 ]: Check File/Folder    2, 02             Check a file or a folder recursively: `clamscan --recursive`
[ 03 ]: Check SYSTEM         3, 03             Check whole system except `/home/` and `/var/lib/flatpak/`
                                               `clamscan --recursive $path_system --exclude-dir="$path_home/*" --exclude-dir="$path_flatpak/*" --log=$current_log`
[ 04 ]: Check HOME           4, 04             Check your home directory only, based on $HOME variable: `clamscan --recursive $HOME/* --log=$current_log`
[ 05 ]: Remove clam logs     5, 05             Remove log files created by this script: `rm --verbose /tmp/clamlog*.log`
