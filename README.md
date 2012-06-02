#Codebreaker

This is Codebreaker, extended from Chelimsky's The RSpec Book, version 2011-12-13.

The master branch will contain all extended features. The original branch contains Codebreaker as it was built and left in The RSpec Book. Other branches will contain new features as they are built on each other.

To play, have at least Ruby 1.8.7 installed, clone, and run 'bin/codebreaker' from the project directory.

##This version: guess validation feature
###Includes previous versions: original

This feature is basic. No new step definitions were needed, as the new scenario outline used previously made regexs. See below for changes made since last feature (original).

#### features/codebreaker_submits_guess.feature
``` gehrkin
A code-breaker's guess is invalid if it has less than four numbers, more
than four numbers, or a non-digit. Invalid guesses should return the message
'You must guess exactly four numbers.' to the code-breaker. For example, the
guesses '123', '12345', and '1d34' should return the invalid guess message.
...
...
Scenario Outline: submit invalid guess
Given the secret code is "1234"
When I guess "<invalid_guess>"
Then I should see "You must guess exactly four numbers."

Scenarios: invalid guess
| invalid_guess |
| 123 |
| 12345 |
| 1d34 |
```

#### spec / codebreaker / game_spec.rb
``` ruby
module Codebreaker
  describe Game do
    let(:output) { double('output').as_null_object }
    let(:game) { Game.new(output) }
    ...
    ...
    describe "#guess" do
      ...
      ...
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
```

#### lib/codebreaker/game.rb
``` ruby
module Codebreaker
  class Game
    INVALID_GUESS_MESSAGE = 'You must guess exactly four numbers.'
    ...
    ...
    def guess(guess)
      if valid_guess?(guess)
        marker = Marker.new(@secret, guess)
        @output.puts '+'*marker.exact_match_count +
                     '-'*marker.number_match_count
      else
        @output.puts INVALID_GUESS_MESSAGE
      end
    end

    def valid_guess?(guess)
      guess_char_count = guess.split('').count

      guess_char_count == 4 &&
      /\d{4}/.match(guess)
    end
  end
end
```

#### bin/codebreaker
``` ruby
...
...
options = %w[1 2 3 4 5 6 7 8 9 0]
...
...
```
