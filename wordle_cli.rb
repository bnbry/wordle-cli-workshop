require "thor"

class WordleCLI < Thor
  WORDS = [
    "HELLO",
    "ROBOT",
    "PANTS",
  ]

  desc "hello NAME", "say hello to NAME"
  def hello(name)
    puts "Hello #{name}"
  end

  desc "go", "start a wordle game"
  def go
    say "Welcome to wordle! Guess a word."
    answer = WORDS.sample
    playing = true

    while playing do
      guess = ask("What is your guess?(hint: it is #{answer})").upcase

      if valid_guess?(guess)
        if guess == answer
          say "you win!"
        else
          say "you lose!"
        end
        playing = false
      else
        say "invalid guess, try again"
        playing = true
      end
    end
  end

  private

  def valid_guess?(guess)
    WORDS.include?(guess)
  end
end
