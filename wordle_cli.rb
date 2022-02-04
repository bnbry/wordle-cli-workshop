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
    valid_guesses = 0

    while playing do
      guess = ask("What is your guess?(hint: it is #{answer})").upcase

      if valid_guesses <= 5
        render_guess(guess, answer)
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

  def render_guess(guess, answer)
    say EnrichedGuess.new(guess: guess, answer: answer).render { |letter| set_color(*letter) }
  end

  class EnrichedGuess
    def initialize(guess:, answer:)
      @guessed_letters = guess.split("").each_with_index.map do |letter, index|
        GuessedLetter.new(letter: letter, index: index, answer: answer)
      end
    end

    def render(&block)
      @guessed_letters.map { |letter| block.call(letter.render) }.join
    end
  end

  class GuessedLetter
    def initialize(letter:, index:, answer:)
      @letter = letter
      @index = index
      @answer = answer
    end

    def render
      [" #{@letter} ", *match_type, :bold]
    end

    private

    def match_type
      if exact_match?
        [:white, :on_green]
      elsif in_word?
        [:black, :on_yellow]
      else
        [:white, :on_black]
      end
    end

    def exact_match?
      @letter == @answer[@index]
    end

    def in_word?
      @answer.include?(@letter)
    end
  end
end
