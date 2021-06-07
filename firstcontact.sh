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

protokoll="http://www.";
url_input="none";
wordlist="/usr/share/dirbuster/wordlists/directory-list-2.3-medium.txt";

while getopts su:w:x:o:?h flag
do
    case "${flag}" in
        s) protokoll="https://www.";;
        u) url_input=${OPTARG}
           file=${OPTARG};;
        w) wordlist=${OPTARG};;  
        x) extentions="-x ${OPTARG}";;
        o) file=${OPTARG};;
        h|?) usage;;
    esac
done

if [ $url_input = "none" ]; then
    echo "-u must be set"
    usage
fi

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

## nmap
echo "Phase 1: scanning Well-Known-Ports" 
echo "##########################################" >> $file
echo "### Phase 1: scanning Well-Known-Ports ###" >> $file
echo "##########################################" >> $file
echo "\n" >> $file

nmap -T4 -sC -sV -p 0-1023  www.$url_input | sed -n '/PORT/,/Nmap/p' >> $file
echo "Phase 1: Done"


## gobuster
echo "Phase 2: brute forcing Sitemap"
echo "\n" >> $file
echo "##########################################" >> $file
echo "##### Phase 2: brute forcing Sitemap #####" >> $file
echo "##########################################" >> $file
echo "\n" >> $file

url=$protokoll$url_input/;
gobuster dir -u $url -w $wordlist $extentions | grep -w '200\|302\|403' 2>/dev/null >> $file

echo "Phase 2: Done"
echo "The output is written to $file"                                                                                               
notify-send 'Notifaction' 'First Contact is finished!'
exit                                                                                                        
                                                                                                        
                                                                                                        
                                                                                                        
                                                                                                        

