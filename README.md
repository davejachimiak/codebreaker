#Codebreaker

This is Codebreaker, extended from Chelimsky's The RSpec Book, version 2011-12-13.

The master branch will contain all extended features. The original branch contains Codebreaker as it was built and left in The RSpec Book. Other branches will contain new features as they are built on each other.

To play, have at least Ruby 1.8.7 installed, clone, and run 'bin/codebreaker' from the project directory.

##This version: code-breaker wins game feature
###Includes previous versions: guess validation, original

This feature is also basic. No new step definitions were needed, as the new scenario outline used previously made regexs. The "valid guess sends the mark to output spec" was changed as to differ from the "congratulates upon perfect guess" spec. System exit on win will be implemented next as it will be easier to test from the result of a "prompt code-breaker for new game" feature. See below for changes made since last feature (guess validation).

#### features/codebreaker_wins_game.feature
``` gherkin
Feature: Codebreaker wins game

  As a codebreaker
  I want to be congratulated when I win the game
  So that I know that I won the game
  And that I feel good about myself for doing so
	
  Scenario: win game
    Given the secret code is "1234"
    When I guess "1234"
    Then I should see "++++"
    And I should see "You won!!!"
```

#### spec/codebreaker/game_spec.rb
``` ruby
module Codebreaker
  describe Game do
    let(:output) { double('output').as_null_object }
    let(:game) { Game.new(output) }
    ...
    ...
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
      ...
      ...
    end
  end
end
```

#### lib/codebreaker/game.rb
``` ruby
module Codebreaker
  class Game
    ...
    CODEBREAKER_WINS_MESSAGE = 'You won!!!'
    ...
    ...
    def guess(guess)
      if valid_guess?(guess)
        marker = Marker.new(@secret, guess)
        @output.puts '+'*marker.exact_match_count +
                     '-'*marker.number_match_count
        @output.puts CODEBREAKER_WINS_MESSAGE if perfect_guess?(guess)
      else
        @output.puts INVALID_GUESS_MESSAGE
      end
    end
    ...
    ...
    def perfect_guess?(guess)
      guess == @secret
    end
  end
end
```
