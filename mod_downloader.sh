#!/bin/bash

###############################################################################
# 			 MODARCHIVE.ORG DOWNLOADER
#
#
#  This script will download mods from modarchive.org to a directory of your 
#  choice. Type -h for help and options. Download by genre, or other search
#  criteria.
#  you will be prompted where you would like to save the mods when you run 
#  the script. 
#
# if you are using mac os x you need to run this command before this will work
# function _wget() { curl "${1}" -o $(basename "${1}") ; }; alias wget='_wget'
#
# Derrived from MODARCHIVE JUKEBOX by Fernando Sancho AKA 'toptnc' (see below)
# by Demonic Sweaters www.demonicsweaters.com released under GNU GPL License
# edits by Milk - https://github.com/mxmilkb/moddownloaderv
###############################################################################
#                        MODARCHIVE JUKEBOX SCRIPT
#	
#  Made by: Fernando Sancho AKA 'toptnc'
#  email: toptnc@gmail.com
#
#  This script plays mods from http://modarchive.org in random order
#  It can fetch files from various categories
#
#  This script is released under the terms of GNU GPL License 
#
###############################################################################

PLAYLISTFILE=/tmp/modarchive.url

#Configuration file overrides defaults
if [ -f $HOME/.config/modarchive/modarchiverc ];
then
    source $HOME/.config/modarchive/modarchiverc
fi

usage()
{
    cat << EOF
usage: $0 [options]

Mod Downloader instructions:
   -h : Show this help message
   -n <number> (REQUIRED) Number of tracks to download
   -s <section> Download from selected section: Can be one of this 
          uploads     This is a list of the recent member upload activity

          featured    These modules have been nominated by the crew for either 
                      outstanding quality, technique or creativity 
                      (or combination of).
          favourites  These modules have been nominated by the members via their
                      favourites. 
          downloads   The top 1000 most downloaded modules, recorded since circa
                      2002. 
          topscore    This chart lists the most revered modules on the archive.
          new         Same than uploads but using search engine

          random      Ramdom module from entire archive

   -a <artist>  Search in artist database
   -m <module>  Search in module database (Title and Filename)
   -g <genre>   Download a specific genre (for the time being this must be done
		by using the genre number at modarchive.org. In order to get the
		number, go to modarchive.org and click the genres page. Hover your
		mouse over the genre and look for the number in the link address.)
		Genre will also ask you for a page number. This is refering to the
		search results page. Leave blank for page 1, then run the script 
		again and enter 2, 3, 4, etc... if you want to download the rest 
		of the pages.


Hint: Use + symbol instead blankspaces in search strings.
Hint 2: if you're running Mac OSX, you must first run this command before the script will run: function _wget() { curl "${1}" -o $(basename "${1}") ; };
alias wget='_wget'

EOF
}


create_playlist()
{
    PLAYLIST=""
    
    if [ -z $PAGES ];
    then
        PLAYLIST=$(wget -o /dev/null -O - "${MODURL}" | grep href | sed 's/href=/\n/g' | sed 's/>/\n/g' | grep downloads.php | sed 's/\"//g' | sed 's/'\''//g'|cut -d " " -f 1| uniq)
    else
	echo "Need to download ${PAGES} pages of results. This may take a while..."
        for (( PLPAGE = 1; PLPAGE <= PAGES; PLPAGE ++ ))
        do
	    (( PERCENT = PLPAGE * 100 / PAGES ))
	    echo -ne "${PERCENT}% completed\r"
            PLPAGEARG="&page=$PLPAGE";
            LIST=$(wget -o /dev/null -O - "${MODURL}${PLPAGEARG}"| grep href | sed 's/href=/\n/g' | sed 's/>/\n/g' | grep downloads.php | sed 's/\"//g' | sed 's/'\''//g'|cut -d " " -f 1| uniq )
            PLAYLIST=$(printf "${PLAYLIST}\n${LIST}")
        done
	echo ""
    fi     
    if [ -z $SHUFFLE ];
    then
        echo "$PLAYLIST" | sed '/^$/d' > $PLAYLISTFILE
    else
        echo "$PLAYLIST" | sed '/^$/d' | awk 'BEGIN { srand() } { print rand() "\t" $0 }' | sort -n | cut -f2- > $PLAYLISTFILE
    fi
}


while getopts "hrm:a:s:n:p:g:" OPTION
do
    case $OPTION in
	h)
	    usage
	    exit 0;
	    ;;   	
	   
	s)
            case $OPTARG in
		uploads)
		    echo -n "where do you want to save the mods? [enter full path]: "
                    read MODPATH
		    MODURL="http://modarchive.org/index.php?request=view_actions_uploads"
		    PAGES=
		    ;;
		featured)
    		    echo -n "where do you want to save the mods? [enter full path]: "
                    read MODPATH
		    MODURL="http://modarchive.org/index.php?request=view_chart&query=featured"
		    PAGES=$(wget  -o /dev/null -O - $MODURL | sed 's/[<>]/\n/g' | grep navlink | tail -n 1 | sed 's/page=/\n/' | tail -n 1 | cut -d "#" -f 1)
		    ;;		
		favourites)
		    echo -n "where do you want to save the mods? [enter full path]: "
                    read MODPATH
		    MODURL="http://modarchive.org/index.php?request=view_top_favourites"
		    PAGES=$(wget  -o /dev/null -O - $MODURL | sed 's/[<>]/\n/g' | grep navlink | tail -n 1 | sed 's/page=/\n/' | tail -n 1 | cut -d "#" -f 1)
		    ;;
		downloads)
		    echo -n "where do you want to save the mods? [enter full path]: "
                    read MODPATH
		    MODURL="http://modarchive.org/index.php?request=view_chart&query=tophits"
		    PAGES=$(wget  -o /dev/null -O - $MODURL | sed 's/[<>]/\n/g' | grep navlink | tail -n 1 | sed 's/page=/\n/' | tail -n 1 | cut -d "#" -f 1)
		    ;;
		topscore)
		    echo -n "where do you want to save the mods? [enter full path]: "
                    read MODPATH
		    MODURL="http://modarchive.org/index.php?request=view_chart&query=topscore"
		    PAGES=$(wget  -o /dev/null -O - $MODURL | sed 's/[<>]/\n/g' | grep navlink | tail -n 1 | sed 's/page=/\n/' | tail -n 1 | cut -d "#" -f 1)
		    ;;
		new)
		    echo -n "where do you want to save the mods? [enter full path]: "
                    read MODPATH
                    MODURL="http://modarchive.org/index.php?request=search&search_type=new_additions"
     		    PAGES=$(wget  -o /dev/null -O - $MODURL | sed 's/[<>]/\n/g' | grep navlink | tail -n 1 | sed 's/page=/\n/' | tail -n 1 | cut -d "#" -f 1)
                    ;;
		
		random)
		    echo -n "where do you want to save the mods? [enter full path]: "
            	    read MODPATH
		    RANDOMSONG="true"
		    MODURL="http://modarchive.org/index.php?request=view_random"
		    PAGES=
		    ;;
		?)
                    usage
                    exit 1
                    ;;
            esac
            ;;
	
	a)
         echo -n "where do you want to save the mods? [enter full path]: "
         read MODPATH   
	 MODURL="http://modarchive.org/index.php?query=${OPTARG}&submit=Find&request=search&search_type=guessed_artist&order=5"
	    PAGES=$(wget  -o /dev/null -O - $MODURL | sed 's/[<>]/\n/g' | grep navlink | tail -n 1 | sed 's/page=/\n/' | tail -n 1 | cut -d "#" -f 1)
            ;;
	
	m) 
	 echo -n "where do you want to save the mods? [enter full path]: "
         read MODPATH          
	 MODURL="http://modarchive.org/index.php?request=search&query=${OPTARG}&submit=Find&search_type=filename_or_songtitle"               
            PAGES=$(wget  -o /dev/null -O - $MODURL | sed 's/[<>]/\n/g' | grep navlink | tail -n 1 | sed 's/page=/\n/' | tail -n 1 | cut -d "#" -f 1)
            ;;
	
	n)	
	    
	    expr $OPTARG + 1 > /dev/null
	    if [ $? = 0 ];
	    then
		TRACKSNUM=${OPTARG};
	    else
		echo "ERROR -n requires a number as argument"
		usage
		exit 1
	    fi		
	    ;;
	
	g) 
            echo -n "enter the page number for genre download and press [enter]: "
	    read GENREPAGE
	    echo -n "where do you want to save the mods? [enter full path]: "
            read MODPATH
	    MODURL="http://lite.modarchive.org/index.php?query=${OPTARG}&request=search&search_type=genre&page=$GENREPAGE#mods"               
            PAGES=$(wget  -o /dev/null -O - $MODURL | sed 's/[<>]/\n/g' | grep navlink | tail -n 1 | sed 's/page=/\n/' | tail -n 1 | cut -d "#" -f 1)
            ;;
	
	?)
	    usage
	    exit 1
	    ;;
    esac
done

if [ -z $MODURL ];
then
    usage
    exit 1
fi

echo "Starting Modarchive Downloader"
LOOP="true"

if [ -z $RANDOMSONG ];
then
    echo "Creating playlist"	
    create_playlist
    TRACKSFOUND=$(wc -l ${PLAYLISTFILE} | cut -d " " -f 1)
    echo "Your query returned ${TRACKSFOUND} results"
fi

COUNTER=1
while [ $LOOP = "true" ]; do
    if [ -z $RANDOMSONG ];
    then
	SONGURL=$(cat ${PLAYLISTFILE} | head -n ${COUNTER} | tail -n 1)
	    let COUNTER=$COUNTER+1
	    if [ $TRACKSNUM -gt 0 ]; 
	    then
		if [ $COUNTER -gt $TRACKSNUM ] || [ $COUNTER -gt $TRACKSFOUND ]; 
		then
		    LOOP="false"
		fi
	    elif [ $COUNTER -gt $TRACKSFOUND ]; 
	    then
		    LOOP="false"
	    fi
    else	
	SONGURL=$(wget -o /dev/null -O - "$MODURL" | sed 's/href=\"/href=\"\n/g' | sed 's/\">/\n\">/g' | grep downloads.php | head -n 1);
	let COUNTER=$COUNTER+1
	if [ $TRACKSNUM -gt 0 ] && [ $COUNTER -gt $TRACKSNUM ]; 
	then
	    LOOP="false"
	fi
    fi

    MODFILE=$(echo "$SONGURL" | cut -d "#" -f 2)
    if [ ! -e "${MODPATH}/${MODFILE}" ]; then
	echo "Downloading $SONGURL to $MODPATH/$MODFILE";
	wget -o /dev/null -O "${MODPATH}/${MODFILE}" "$SONGURL";
    fi
    #if [ -e "${MODPATH}/${MODFILE}" ];then
	# "${MODPATH}/${MODFILE}"
    #fi
done

