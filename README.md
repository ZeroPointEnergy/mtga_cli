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

First you have to import the scryfall card database:

    $ wget https://archive.scryfall.com/json/scryfall-default-cards.json
    $ bundle exec mtga-cli db import ./scryfall-default-cards.json

Then update your collection:

    $ bundle exec mtga-cli collection update ~/Games/magic-the-gathering-arena/drive_c/users/${USER}/AppData/LocalLow/Wizards\ Of\ The\ Coast/MTGA/output_log.txt

Now you can print the summary:

    $ bundle exec exe/mtga-cli collection summary

    Set 'Guilds of Ravnica' (grn)
    Overall: 601/1092 complete: 55.04
      - Common 316/472 complete: 66.95
      - Uncommon 205/328 complete: 62.50
      - Rare 66/220 complete: 30.00
      - Mythic 14/72 complete: 19.44

    Set 'Core Set 2019' (m19)
    Overall: 558/1256 complete: 44.43
      - Common 267/572 complete: 46.68
      - Uncommon 211/344 complete: 61.34
      - Rare 70/252 complete: 27.78
      - Mythic 10/88 complete: 11.36

    Set 'Dominaria' (dom)
    Overall: 462/1120 complete: 41.25
      - Common 220/500 complete: 44.00
      - Uncommon 169/328 complete: 51.52
      - Rare 56/224 complete: 25.00
      - Mythic 17/68 complete: 25.00

    Set 'Rivals of Ixalan' (rix)
    Overall: 267/820 complete: 32.56
      - Common 105/312 complete: 33.65
      - Uncommon 112/248 complete: 45.16
      - Rare 38/200 complete: 19.00
      - Mythic 12/60 complete: 20.00

    Set 'Ixalan' (xln)
    Overall: 244/1156 complete: 21.11
      - Common 79/500 complete: 15.80
      - Uncommon 117/328 complete: 35.67
      - Rare 40/260 complete: 15.38
      - Mythic 8/68 complete: 11.76 

## License

The gem is available as open source under the terms of the GPL v3.
