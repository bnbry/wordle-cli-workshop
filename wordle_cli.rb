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
    guess = ask("What is your guess?(hint: it is #{answer})").upcase

    if valid_guess?(guess)
      if guess == answer
        say "you win!"
      else
        say "you lose!"
      end
    else
      say "invalid guess, try again"
    end
  end

  private

  def valid_guess?(guess)
    WORDS.include?(guess)
  end
end
