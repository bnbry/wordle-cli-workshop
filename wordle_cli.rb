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
    guess = ask "What is your guess?(hint: it is #{answer})"

    if guess.upcase == answer
      say "you win!"
    else
      say "you lose!"
    end
  end
end
