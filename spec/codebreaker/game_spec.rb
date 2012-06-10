require 'spec_helper'

module Codebreaker
  describe Game do
    let(:output) { double('output').as_null_object }
    let(:game)   { Game.new(output) }

    describe "#start" do
      it "sends a welcome message" do
        output.should_receive(:puts).with('Welcome to Codebreaker!')
        game.start('1234')
      end

      it "prompts for the first guess" do
        output.should_receive(:puts).with('Enter guess:')
        game.start('1234')
      end
    end

    describe "#guess" do
      context "valid guess" do
        it "sends the mark to output" do
          game.start('1234')
	  output.should_receive(:puts).with('+++')
	  game.guess('1235')
        end
        
	it "congratulates upon perfect guess" do
          game.start('1234')
	  output.should_receive(:puts).with('++++')
	  output.should_receive(:puts).with('You won!!!')
	  game.guess('1234')
	end
      end

      context "invalid guess" do
        let(:message) { 'You must guess exactly four numbers.' }
	before(:each) do
          game.start('1234')
	  output.should_receive(:puts).with(message)
        end

	it "sends invalid message for less than four" do
	  game.guess('123')
        end

        it "sends invalid message for more than four numbers" do
	  game.guess('12345')
        end
	
	it "sends invalid message for any non-digit character" do
	  game.guess('1b3b')
        end
      end
    end
  end
end
