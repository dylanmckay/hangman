#! /usr/bin/ruby

require_relative "hangman.rb"

word = File.read("words.txt").split("\n").sample()
model = HangmanModel.new(word)
view = HangmanView.new()
controller = HangmanController.new(model, view)

controller.play

