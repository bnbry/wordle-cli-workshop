# wordle-cli

### set up the repo

- `git clone ...`
- `cd ...`
- `bundle install`

### basic hello world thor cli and bin executable

- create wordle_cli.rb and bin/wordle
- change permissions of bin/wordle(`chmod 777 bin/wordle`)
- call wordle_cli from bin/wordle and pass ARGV capture
- ARGV is basically the array of inputs from the command line

### execute hello world app

- `bin/wordle`
- `bin/wordle help hello`
- `bin/wordle hello world`

### guess words!

- set up a basic dictionary
- change the wordle CLI to take guesses using say/ask
- show results

### add constraints!

- word must be in the list of words
- player can retry as many times as possible on invalid words
- player limited to retry 6 times on valid word failures

### Enrich guessing/matching feedback

- display guess with colors if a letter matches
- extract and clean up code a bit

### Add options to pass in dictionary

- dictionary file
- document options and accept them with fallback
- file parsing

### Maybe clean this up!

- clean up code
- show all letters and their current status
- add specs?
