#! /usr/bin/ruby

GUESS_COUNT = 8

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

  def decrement_remaining_turns
    fail if @remaining_turns <= 0
    @remaining_turns -= 1
  end

  # gets a the word as a character array, with unguessed letters
  # being represented by 'nil'.
  def status_chars
    @word.chars.map { |c| @correct_letters.include?(c) ? c : nil }
  end
end

class HangmanController

  def initialize(model, view)
    @model = model
    @view = view
  end

  def play
    @view.show_guess_count(@model.remaining_turns)

    play_turn while @model.in_progress?

    if @model.won?
      @view.show_win_message(@model.word)
    else
      @view.show_lose_message(@model.word)
    end

  end

  def play_turn
    @view.show_word_status(@model.status_chars)

    letter = @view.prompt_letter

    if @model.already_guessed?(letter)
      @view.show_already_guessed_message(letter)
    else
      process_letter(letter)
    end
  end

  def process_letter(letter)

    success = @model.try_give_letter(letter)
    @model.decrement_remaining_turns if !success
  end
end

class HangmanView
  def prompt_letter
    loop do
      print("Enter a letter: ")
      letter = gets.chomp

      if letter.length == 1
        return letter
      else
        puts("Please enter a single character")
      end
    end
  end

  def show_guess_count(count)
    puts "You have #{count} guesses"
  end

  def show_win_message(word)
      puts("You won! The word was '#{word}'")
  end

  def show_lose_message(word)
    puts("You ran out of turns :( The word was '#{word}'")
  end

  def show_word_status(chars)
    puts("The word is '#{current_word_status_str(chars)}'")
  end

  def show_already_guessed_message(letter)
      puts("You have already correctly guessed '#{letter}'")
  end

  def current_word_status_str(chars)
    chars.map { |c| c == nil ? '_' : c }.join
  end
end

if __FILE__ == $0
  word = File.read("words.txt").split("\n").sample()
  model = HangmanModel.new(word)
  view = HangmanView.new()
  controller = HangmanController.new(model, view)

  controller.play
end
