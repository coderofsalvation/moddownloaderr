`moddownloaderr` - a bash script that downloads tracker created module music files (.mod, .med, .xm, .it, .s3m) from modarchive.org. You can use various category or search criteria, as well as save locations for each download session, or set the maximum number of tracks to download. This is a quick way to get a huge mod library on your computer.

### History
Based on the modarchive script by Fernando Sancho AKA 'toptnc' - https://github.com/toptnc/modarchive, modifications by Justin Wierbonski aka Demonic Sweaters - https://github.com/demonicsweaters/moddownloader, and updates by Milkii Brewster - https://github.com/mxmilkb/moddownloaderr

### Install 
Required packages:
* wget
* sed
* grep
* awk

Available from the [AUR](https://aur.archlinux.org/packages/moddownloaderr/) for Arch Linux and related distros.

Quick setup:
```
mkdir ~/bin
cd ~/bin
git clone https://github.com/mxmilkb/moddownloaderr
ln -s moddownloaderr/moddownloaderr
```

### Usage
Warning: do not run multiple copies at the same time (yet).

```
Mod Downloaderr options:
  -h               Show this help message
  -n <number>      Optionally cap the total number of tracks to download
  -s <section>     Download from selected section: Can be one of this
       uploads     This is a list of the recent member upload activity, 80 files
       new         Same a uploads but using search engine, 150 files
       featured    These modules have been nominated by the crew for either
                     outstanding quality, technique or creativity (or
                     combination of).
       favourites  These modules have been nominated by the members via their
                     favourites.
       downloads   The top 1000 most downloaded modules, recorded since circa
                     2002.
       topscore    This chart lists the most revered modules on the archive.
       random      Ramdom module from entire archive
   -a <artist>     Search in artist database
   -m <module>     Search in module database (Title and Filename)
   -g [<genrenum>] Download a specific genre. Either enter the modarchive.org
                     genres number, or select from a list.
   -d              Enable debug message output.
   
Hint: Use + symbol instead blankspaces in search strings.
Hint 2: If you're running Mac OSX, you must first run this command before the
script will run:
  function _wget() { curl "${1}" -o $(basename "${1}") ; }; alias wget='_wget'
Hint 3: Use 'MDDEBUG=1 moddownloaderr' to enable debug output.
Hint 4: Some tracks are in more than one genre category. Use dupeguru to remove
duplicate files.
```

Use [Mixxx](https://mixxx.org/) to DJ modules ([details](https://blueprints.launchpad.net/mixxx/+spec/mod-music-playback#edit-whiteboard)). See also https://wiki.thingsandstuff.org/Tracker.
