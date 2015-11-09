#! /usr/bin/ruby

GUESS_COUNT = 8

class Hangman
  attr_reader :word

  def initialize(word)
    @word = word
    @correct_letters = []
  end

  def perform_turn(letter)
    if @word.chars.include?(letter) 
      @correct_letters << letter
    end
  end

  def word_guessed?
    @correct_letters.length == @word.chars.uniq.length
  end

  def current_word_status
   @word.chars.map do |c|
      if @correct_letters.include?(c)
        c
      else
        '_'
      end
   end.join
  end

  def already_guessed?(letter)
    @correct_letters.include?(letter)
  end
end

class UI
  def initialize(game)
    @game = game
  end

  def play

  puts "You have #{GUESS_COUNT} guesses"

  GUESS_COUNT.times do
    play_turn

    if @game.word_guessed?
      puts("You won! The word was #{@game.word}")
      return
    end
  end

  puts("You ran out of turns :( The word was '#{@game.word}'")
  end

  def play_turn
  puts("The word is '#{@game.current_word_status}'")

  letter = prompt_letter

  if @game.already_guessed?(letter)
    puts("You have already correctly guessed this")
  else
    @game.perform_turn(letter)
  end
  end

  def prompt_letter
  letter = nil

  # wait for valid input
  until letter
    print("Enter a letter: ")
    letter = gets.chomp

    if letter.length != 1
      puts("Please enter a single character")
      letter = nil
    end
  end
  letter
  end


end

word = File.read("words.txt").split("\n").sample()
game = Hangman.new(word)
ui = UI.new(game)

ui.play
