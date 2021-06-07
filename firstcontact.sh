#! /bin/sh

## help page
usage()
{
  echo "Usage: $0 [-u] [URL|IP] [Options]"
  echo "\n"
  echo "Options:"
  echo "-s = https"
  echo "-w = gobuster -> wordlist"
  echo "-x = gobuster -> extentions like php or html"
  echo "-o = to define the output filename"
  exit 2
}

protokoll="http://";
url_input="none";
wordlist="/usr/share/dirbuster/wordlists/directory-list-2.3-medium.txt";

while getopts su:w:x:o:?h flag
do
    case "${flag}" in
        s) protokoll="https://";;

        u) url_input=${OPTARG}
            file=${OPTARG};;

        w) wordlist=${OPTARG};;  

        x) extentions=", ${OPTARG}";;

        o) file=${OPTARG};;

        h|?) usage;;
    esac
done

if [ $url_input = "none" ]; then
    echo "-u must be set"
    usage
fi

url=$protokoll$url_input/;

######################
## Main script

echo "\n" | tee $file
echo "███████╗██╗██████╗ ███████╗████████╗     ██████╗ ██████╗ ███╗   ██╗████████╗ █████╗  ██████╗████████╗" | tee -a $file
echo "██╔════╝██║██╔══██╗██╔════╝╚══██╔══╝    ██╔════╝██╔═══██╗████╗  ██║╚══██╔══╝██╔══██╗██╔════╝╚══██╔══╝" | tee -a $file
echo "█████╗  ██║██████╔╝███████╗   ██║       ██║     ██║   ██║██╔██╗ ██║   ██║   ███████║██║        ██║   " | tee -a $file
echo "██╔══╝  ██║██╔══██╗╚════██║   ██║       ██║     ██║   ██║██║╚██╗██║   ██║   ██╔══██║██║        ██║   " | tee -a $file
echo "██║     ██║██║  ██║███████║   ██║       ╚██████╗╚██████╔╝██║ ╚████║   ██║   ██║  ██║╚██████╗   ██║   " | tee -a $file
echo "╚═╝     ╚═╝╚═╝  ╚═╝╚══════╝   ╚═╝        ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝   ╚═╝   ╚═╝  ╚═╝ ╚═════╝   ╚═╝   " | tee -a $file
echo "version 0.0" | tee -a $file
echo "author: mueller-ger" | tee -a $file
echo "\n" | tee -a $file

echo "I've got a 4-alarm hangover. It's either from all that whiskey, or your laser beam. Or both. \n But I'm ready to make history."
echo "Zefram Cochran"
echo "Zefram Cochran \n"

##checking if host is online
echo "Phase 0: checking if host is alive" 
if ping -c 1 -W 1 "$url_input" 2>&1 >/dev/null; then
    echo "$url is alive" 

else
     echo "host is not alive"
     exit 2
fi

echo "\n" 

## nmap
echo "Phase 1: scanning Well-Known-Ports" 
echo "##########################################" >> $file
echo "### Phase 1: scanning Well-Known-Ports ###" >> $file
echo "##########################################" >> $file
echo "\n" >> $file

nmap -T4 -sC -sV -p 0-1023  $url_input | sed -n '/PORT/,/Nmap/p' >> $file
echo "Phase 1: Done"
echo "\n" 

## gobuster
echo "Phase 2: brute forcing Sitemap"
echo "\n" >> $file
echo "##########################################" >> $file
echo "##### Phase 2: brute forcing Sitemap #####" >> $file
echo "##########################################" >> $file
echo "\n" >> $file

### wordlist_firstcontact.txt
echo "### wordlist_firstcontact.txt" >> $file
if test -f "wordlist_firstcontact.txt"; then
    gobuster dir -u $url -w wordlist_firstcontact.txt -x php,txt$extentions | grep -w '200\|302\|403' 2>/dev/null >> $file
else
    echo "The wordlist wordlist_firstcontact.txt does not exist"  | tee -a $file
fi
echo "\n" >> $file

### your wordlist
echo "### $wordlist" >> $file
if test -f "$wordlist"; then
    gobuster dir -u $url -w $wordlist -x php,txt$extentions | grep -w '200\|302\|403' 2>/dev/null >> $file
else 
    echo "The wordlist $wordlist does not exist"  | tee -a $file
fi
echo "\n" >> $file

echo "Phase 2: Done"
echo "\n" 
echo "The output is written to $file"                                                                                               
notify-send 'Notifaction' 'First Contact is finished!'
exit                                                                                                        
                                                                                                        
                                                                                                        
                                                                                                        
                                                                                                        

