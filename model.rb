
class HangmanModel
  attr_reader :word, :remaining_turns

  def initialize(word)
    @word = word
    @correct_letters = []
    @remaining_turns = GUESS_COUNT
  end

  def contain_letter?(letter)
    @word.chars.include?(letter)
  end

  def try_give_letter(letter)
    if contain_letter?(letter)
      @correct_letters << letter
      true
    else
      false
    end
  end

  def already_guessed?(letter)
    @correct_letters.include?(letter)
  end

  def remaining_turns?
    @remaining_turns > 0
  end

  def in_progress?
    remaining_turns? && !won?
  end

  def won?
    @correct_letters.length == @word.chars.uniq.length
  end

  def take_life
    fail if @remaining_turns <= 0
    @remaining_turns -= 1
  end

  # gets a the word as a character array, with unguessed letters
  # being represented by 'nil'.
  def status_chars
    @word.chars.map { |c| @correct_letters.include?(c) ? c : nil }
  end
end

