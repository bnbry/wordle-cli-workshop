module WordleApp
  class EnrichedGuess
    def initialize(guess:, answer:, valid_words:, letter_renderer:)
      @guess = guess
      @answer = answer
      @valid_words = valid_words
      @letter_renderer = letter_renderer
      @guessed_letters = guess.split("").each_with_index.map do |letter, index|
        GuessedLetter.new(letter: letter, index: index, answer: answer)
      end
    end

    def result
      if success?
        :success
      elsif valid?
        :valid
      else
        :invalid
      end
    end

    def render
      if valid?
        @guessed_letters.map { |letter| @letter_renderer.call(letter.render) }.join
      else
        @guessed_letters.map { |letter| @letter_renderer.call(letter.render_plain) }.join
      end
    end

    private

    def success?
      return false unless valid?

      @guess == @answer
    end

    def valid?
      @valid_words.include?(@guess)
    end
  end
end
