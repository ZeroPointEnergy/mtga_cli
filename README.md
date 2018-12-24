# MTGA CLI

This is a small ruby CLI application to print some stats about the Magic the Gathering: Arena card collection.

This is very basic and was developed and tested on Linux only so far. This only shows some rudementary stats and nothing fancy so far.

## Installation

Checkout this source code repository and run bundler to install all the gems:

    git clone https:://github.com/ZeroPointEnergy/mtga_cli.git
    cd mtga_cli
    bundle install --path .bundle

## Usage

Execute the application with bundler:

    $ bundle exec mtga-cli --help

This will configure the application and set the output log location:

    $ bundle exec mtga-cli --output_log ${Home}/Games/magic-the-gathering-arena/drive_c/users/${USER}/AppData/LocalLow/Wizards\ Of\ The\ Coast/MTGA/output_log.txt initconfig

First you have to import the scryfall card database:

    $ wget https://archive.scryfall.com/json/scryfall-default-cards.json
    $ bundle exec mtga-cli db import ./scryfall-default-cards.json

Then update your collection:

    $ bundle exec mtga-cli collection update

Now you can print the summary:

    $ bundle exec exe/mtga-cli collection summary

    Set 'Guilds of Ravnica' (grn)
    Overall: 621/1072 complete: 57.93%
      - Common 328/452 complete: 72.57%
      - Uncommon 210/328 complete: 64.02%
      - Rare 69/220 complete: 31.36%
      - Mythic 14/72 complete: 19.44%

    Set 'Core Set 2019' (m19)
    Overall: 562/1176 complete: 47.79%
      - Common 267/492 complete: 54.27%
      - Uncommon 215/344 complete: 62.50%
      - Rare 70/252 complete: 27.78%
      - Mythic 10/88 complete: 11.36%

    Set 'Dominaria' (dom)
    Overall: 467/1040 complete: 44.90%
      - Common 221/420 complete: 52.62%
      - Uncommon 173/328 complete: 52.74%
      - Rare 56/224 complete: 25.00%
      - Mythic 17/68 complete: 25.00%

    Set 'Rivals of Ixalan' (rix)
    Overall: 273/800 complete: 34.12%
      - Common 105/292 complete: 35.96%
      - Uncommon 116/248 complete: 46.77%
      - Rare 40/200 complete: 20.00%
      - Mythic 12/60 complete: 20.00%

    Set 'Ixalan' (xln)
    Overall: 301/1076 complete: 27.97%
      - Common 113/420 complete: 26.90%
      - Uncommon 134/328 complete: 40.85%
      - Rare 46/260 complete: 17.69%
      - Mythic 8/68 complete: 11.76%

Or the history of new cards in the collection between updates:

    $ bundle exec exe/mtga-cli collection history -n 1

    2018-12-20 01:27:46 +0100 => 2018-12-21 17:28:57 +0100
      Set 'Guilds of Ravnica' (grn)
        +1 Hellkite Whelp (uncommon)
      Set 'Ixalan' (xln)
        +1 Waker of the Wilds (rare)
        +1 River Heralds' Boon (common)
        +1 Ixalli's Keeper (common)
        +1 Sun-Crowned Hunters (common)
        +1 Demolish (common)
        +1 Deathless Ancient (uncommon)
        +1 Storm Sculptor (common)
        +1 Run Aground (common)
        +1 Prosperous Pirates (common)
        +1 Fleet Swallower (rare)
        +1 Steadfast Armasaur (uncommon)
        +1 Looming Altisaur (common)
        +1 Bishop's Soldier (common)

## License

The gem is available as open source under the terms of the GPL v3.
