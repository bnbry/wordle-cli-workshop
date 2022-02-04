module WordleApp
  class GuessedLetter
    def initialize(letter:, index:, answer:)
      @letter = letter
      @index = index
      @answer = answer
    end

    def render
      [" #{@letter} ", *match_type, :bold]
    end

    def render_plain
      [" #{@letter} ", :white, :on_red, :bold]
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
