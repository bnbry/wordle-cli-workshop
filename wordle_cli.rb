require "thor"
require_relative "wordle_app/guessed_letter"
require_relative "wordle_app/enriched_guess"

class WordleCLI < Thor
  WORDS = [
    "HELLO",
    "ROBOT",
    "PANTS",
    "SHARK",
    "CODES",
    "SPIFF",
    "WORDS",
    "SHAPE",
    "SHARP",
    "SHARE",
    "HARES",
  ]

  desc "go", "start a wordle game"
  option :words, :type => :string
  option :w, :type => :string
  long_desc <<-LONGDESC
    This lets you play a cool game of wordle kind of

    With -w, --words option, wordle go -w="path/to/file.txt" lets you load an external words list
  LONGDESC
  def go
    wordlist = parse_wordlist(options) || WORDS
    say "Welcome to wordle! Guess a word."
    answer = wordlist.sample
    playing = true
    valid_guesses = 1

    while playing do
      guess = ask("What is your guess?(#{valid_guesses}/6)")
        .upcase
        .then do |raw_guess|
          ::WordleApp::EnrichedGuess.new(
            guess:           raw_guess,
            answer:          answer,
            valid_words:     wordlist,
            letter_renderer: ->(letter) { set_color(*letter) }
          )
        end

      if valid_guesses < 6
        say guess.render

        case guess.result
        when :success
          say "you guessed correctly"
          playing = false
        when :valid
          say "please guess again"
          playing = true
          valid_guesses += 1
        when :invalid
          say "invalid guess, try again"
          playing = true
        end
      else
        say "out of guesses, you lose!"
        playing = false
      end
    end
  end

  private

  def parse_wordlist(options)
    filepath = options[:w] || options[:words]

    return unless filepath

    File.readlines(filepath).map { |word| word.upcase.slice(0..5).delete("\n") }
  end
end
