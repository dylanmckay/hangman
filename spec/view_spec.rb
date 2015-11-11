
require_relative "../hangman.rb"

describe HangmanView do

  let(:view) { HangmanView.new }

  describe "#prompt_letter" do
    it "validates that a single character was passed" do
      expect(view).to receive(:gets).and_return("asdf\n")
      expect(view).to receive(:gets).and_return("")
      expect(view).to receive(:gets).and_return("a\n")

      expect(view.prompt_letter).to eq "a"
    end
  end

  describe "#show_word_status" do
    context "when a completely unknown word" do
      it "correctly prints the status string" do
        expect(view).to receive(:puts).with(match(/_a_b/))
        view.show_word_status([nil,'a',nil,'b'])
        
        expect(view).to receive(:puts).with(match(/____/))
        view.show_word_status([nil,nil,nil,nil])

        expect(view).to receive(:puts).with(match(/abcd/))
        view.show_word_status("abcd".chars)
      end
    end
  end
end
