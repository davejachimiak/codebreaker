#Codebreaker

This is Codebreaker, extended from Chelimsky's The RSpec Book, version 2011-12-13.

The master branch will contain all extended features. The original branch contains Codebreaker as it was built and left in The RSpec Book. Other branches will contain new features as they are built on each other.

To play, have at least Ruby 1.8.7 installed, clone, and run 'bin/codebreaker' from the project directory.

##This version: guess validation feature
###Includes previous versions: original

This feature is basic. No new step definitions were needed, as the new scenario outline used previously made regexs. See the bottom of the codebreaker submits guess feature for invalid guess scenarios. See the game spec and game.rb to see how the guess validation feature was implemented. The digit options in bin/codebreaker now include all digits (was 1-6) as to not complicate this particular story.
