`mod_downloader.sh` is a small script that downloads mod files from modarchive.org. You can select the amount of files you want to download and use various search criteria as well as save locations for each download session. This is a quick way to get a huge mod library on your computer.

Based on the modarchive script by Fernando Sancho AKA 'toptnc', modifications by Justin Wierbonski aka Demonic Sweaters, and edits by Milk - https://github.com/mxmilkb/moddownloader

Required packages:
* mikmod, opencp or audacious
* curl
* html2text
* sed
* grep
* awk

Warning: do not run multiple copies at the same time (yet)


```
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
Hint 2: (UNTESTED) if you're running Mac OSX, you must first run this command before the script will run: function _wget() { curl "" -o  ; };
alias wget='_wget'
