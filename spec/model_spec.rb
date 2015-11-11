
require_relative "../hangman.rb"

describe HangmanModel do
  let(:test_word) { "hello" }
  let(:model) { HangmanModel.new(test_word) }

  describe "#won?" do
    it "correctly recognizes every target letter" do
      expect(model.won?).to eq false

      test_word.chars.uniq.each do |c|
        model.try_give_letter(c)
      end

      expect(model.won?).to eq true
    end
  end

  describe "#status_chars" do
    it "doesn't reveal any characters in a new word" do
      expect(model.status_chars.all? { |c| c==nil }).to eq true
    end

    it "prints all characters in a fully-known word" do
      test_word.chars.uniq.each do |c|
        model.try_give_letter(c)
      end

      expect(model.status_chars.all? { |c| c!= nil }).to eq true
    end
  end

  describe "#already_guessed?" do
    it "recognizes that characters were already tried" do
      test_word.chars.uniq.each do |c|
        expect(model.already_guessed?(c)).to eq false
        model.try_give_letter(c)
        expect(model.already_guessed?(c)).to eq true
      end
    end
  end

  describe "#contain_letter?" do
    it "doesn't pretend to contain letters it doesn't really contain" do

      alphabet = "abcdefghijklmnopqrstuvwxyz".chars
      non_occuring_characters = alphabet - test_word.chars

      non_occuring_characters.each do |c|
        expect(model.contain_letter?(c)).to eq false
      end
    end

    it "knows that it contains letters that it really contains" do
      test_word.chars.each do |c|
        expect(model.contain_letter?(c)).to eq true
      end
    end
  end

  describe "#in_progress?" do
    it "recognises that the game has stopped progressing when lost" do
      expect(model.in_progress?).to eq true

      test_word.chars.uniq.each do |c|
        model.try_give_letter(c)
      end

      expect(model.in_progress?).to eq false
    end
  end
end
