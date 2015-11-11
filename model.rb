
GUESS_COUNT = 8

class HangmanModel
  attr_reader :word, :remaining_turns

  def initialize(word, guess_count=GUESS_COUNT)
    @word = word
    @guessed_letters = []
    @remaining_turns = guess_count
  end

  def contain_letter?(letter)
    @word.chars.include?(letter)
  end

  def try_give_letter(letter)
    if !already_guessed?(letter)
      @guessed_letters << letter
    end

    contain_letter?(letter)
  end

  def already_guessed?(letter)
    @guessed_letters.include?(letter)
  end

  def remaining_turns?
    @remaining_turns > 0
  end

  def in_progress?
    remaining_turns? && !won?
  end

  def correctly_guessed_letters
    @guessed_letters.select { |c| contain_letter?(c) }
  end

  def won?
    correctly_guessed_letters.length == @word.chars.uniq.length
  end

  def take_life
    fail if @remaining_turns <= 0
    @remaining_turns -= 1
  end

  # gets a the word as a character array, with unguessed letters
  # being represented by 'nil'.
  def status_chars
    @word.chars.map { |c| @guessed_letters.include?(c) ? c : nil }
  end
end

