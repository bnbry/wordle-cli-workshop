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
  def go
    say "Welcome to wordle! Guess a word."
    answer = WORDS.sample
    playing = true
    valid_guesses = 1

    while playing do
      guess = ask("What is your guess?(#{valid_guesses}/6)(hint: it is #{answer})")
        .upcase
        .then do |raw_guess|
          ::WordleApp::EnrichedGuess.new(
            guess:           raw_guess,
            answer:          answer,
            valid_words:     WORDS,
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
end
