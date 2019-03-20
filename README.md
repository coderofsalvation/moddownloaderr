`moddownloaderr` is a bash script that downloads tracker created module music files (.mod, .xm, .it, .s3m) from modarchive.org. You can select the amount of files you want to download and use various search criteria as well as save locations for each download session. This is a quick way to get a huge mod library on your computer.

Based on the modarchive script by Fernando Sancho AKA 'toptnc' - https://github.com/toptnc/modarchive, modifications by Justin Wierbonski aka Demonic Sweaters - https://github.com/demonicsweaters/moddownloader, and updates by Milk - https://github.com/mxmilkb/moddownloaderr

Required packages:
* mikmod, opencp or audacious
* curl
* html2text
* sed
* grep
* awk

Warning: do not run multiple copies at the same time (yet)

```
Mod Downloaderr options:
  -h               Show this help message
  -n <number>      Number of tracks to download
  -s <section>     Download from selected section: Can be one of this
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
       
   -a <artist>     Search in artist database
   -m <module>     Search in module database (Title and Filename)
   -g [<genrenum>] Download a specific genre. Either enter the modarchive.org
                     genres number, or select from a list.

Hint: Use + symbol instead blankspaces in search strings.

Hint 2: if you're running Mac OSX, you must first run this command before the
script will run:
  function _wget() { curl "${1}" -o $(basename "${1}") ; }; alias wget='_wget'
  
Hint 3: Use 'MDDEBUG=1 path/moddownloaderr' to enable debug output.
```

Use `mixxx` to play modules - https://blueprints.launchpad.net/mixxx/+spec/mod-music-playback#edit-whiteboard

See also https://wiki.thingsandstuff.org/Tracker
