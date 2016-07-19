#!/usr/bin/env ruby
require_relative 'lingua'
require 'colorize'

class GitHaiku


	def initialize
		@dict = []
		File.open('./dictionary.txt').each {|word| @dict << word}
	end

	def run
		haiku_msg = get_n_syllable_word(5).join(" ")
		haiku_msg.concat("; #{get_n_syllable_word(7).join(" ")}")
		haiku_msg.concat("; #{get_n_syllable_word(5).join(" ")}")
		# p haiku_msg
		git_msg = "git commit -m '#{haiku_msg}'"
		git_output = "git commit -m"
		print git_output.concat(" '#{haiku_msg}''".colorize(:red))
		puts
		system(git_msg)

	end

	def get_n_syllable_word(n)
		n_syl_words = []
		syllable_count = 0


		until syllable_count == n
			rand_word = @dict.sample
			this_word_syllables = Lingua::EN::Syllable.syllables(rand_word)

			if (this_word_syllables + syllable_count) <= n
				n_syl_words << rand_word.strip
				n_syl_words
				syllable_count += this_word_syllables
			end
		end

		n_syl_words
	end#hey

end

if __FILE__ == $PROGRAM_NAME
	GitHaiku.new.run
end
