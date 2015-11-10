
require_relative "../hangman.rb"

ALPHABET = "abcdefghijklmnopqrstuvwxyz".chars
TEST_WORD = "hello"
NON_OCCURING_CHARACTERS = ALPHABET - TEST_WORD.chars

describe HangmanModel do
 let(:model) { HangmanModel.new(TEST_WORD) }

  describe "#won?" do
    it "correctly recognizes every target letter" do
      expect(model.in_progress?).to eq true

      TEST_WORD.chars.uniq.each do |c|
        model.try_give_letter(c)
      end

      expect(model.in_progress?).to eq false
      expect(model.won?).to eq true
    end
  end

  describe "#status_chars" do
    it "doesn't reveal any characters in a new word" do
      expect(model.status_chars.all? { |c| c==nil }).to eq true
    end

    it "prints all characters in a fully-known word" do
      TEST_WORD.chars.uniq.each do |c|
        model.try_give_letter(c)
      end

      expect(model.status_chars.all? { |c| c!= nil }).to eq true
    end
  end

  describe "#already_guessed?" do
    it "recognizes that characters were already tried" do
      TEST_WORD.chars.uniq.each do |c|
        expect(model.already_guessed?(c)).to eq false
        model.try_give_letter(c)
        expect(model.already_guessed?(c)).to eq true
      end
    end
  end

  describe "#contain_letter?" do
    it "doesn't pretend to contain letters it doesn't really contain" do
      NON_OCCURING_CHARACTERS.each do |c|
        expect(model.contain_letter?(c)).to eq false
      end
    end
  end

  describe "#in_progress?" do
    it "recognises that the game has stopped progressing when lost" do
      expect(model.in_progress?).to eq true

      TEST_WORD.chars.uniq.each do |c|
        model.try_give_letter(c)
      end

      expect(model.in_progress?).to eq false
    end
  end
end
