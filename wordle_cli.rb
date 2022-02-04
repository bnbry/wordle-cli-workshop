require "thor"

class WordleCLI < Thor
  WORDS = [
    "HELLO",
    "ROBOT",
    "PANTS",
    "SHARK",
    "CODES",
    "SPIFF",
    "WORDS",
  ]

  desc "go", "start a wordle game"
  def go
    say "Welcome to wordle! Guess a word."
    answer = WORDS.sample
    playing = true
    valid_guesses = 0

    while playing do
      guess = ask("What is your guess?(hint: it is #{answer})").upcase

      if valid_guesses <= 5
        if valid_guess?(guess)
          if guess == answer
            say "you win!"
            playing = false
          else
            say "not the right word!"
            playing = true
            valid_guesses += 1
          end
        else
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

  def valid_guess?(guess)
    WORDS.include?(guess)
  end
end
