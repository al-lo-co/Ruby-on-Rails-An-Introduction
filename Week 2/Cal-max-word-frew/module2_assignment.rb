#Implement all parts of this assignment within (this) module2_assignment2.rb file

#Implement a class called LineAnalyzer.
class LineAnalyzer
#Implement the following read-only attributes in the LineAnalyzer class. 
#* highest_wf_count - a number with maximum number of occurrences for a single word (calculated)
#* highest_wf_words - an array of words with the maximum number of occurrences (calculated)
#* content          - the string analyzed (provided)
#* line_number      - the line number analyzed (provided)

  attr_reader :highest_wf_words, :highest_wf_count, :content, :line_number

#Add the following methods in the LineAnalyzer class.
#* initialize() - taking a line of text (content) and a line number
#* calculate_word_frequency() - calculates result


#Implement the initialize() method to:
#* take in a line of text and line number
#* initialize the content and line_number attributes
#* call the calculate_word_frequency() method.

  def initialize(content, line_number)
    @content = content
    @line_number = line_number
    calculate_word_frequency()
  end


#Implement the calculate_word_frequency() method to:
#* calculate the maximum number of times a single word appears within
#  provided content and store that in the highest_wf_count attribute.
#* identify the words that were used the maximum number of times and
#  store that in the highest_wf_words attribute.

  def calculate_word_frequency() 
    @highest_wf_count = 0
    @highest_wf_words = []
    arr_words = words(self.content.downcase)
    arr_words.uniq.each do |word|
      if (arr_words.count(word) > @highest_wf_count) && (arr_words.count(word) >= 2)
        @highest_wf_count = arr_words.count(word)
        @highest_wf_words.push(word)
      elsif arr_words.count(word) == @highest_wf_count
        @highest_wf_words.push(word)
      end
    end
    @highest_wf_words
    @highest_wf_words = @highest_wf_words.uniq
  end


  private
  def words(content)
    words = []
    word = []
    line = content
    count = 0
    while count < line.length
      letra = line[count]
      if letra != " "
        word.push(letra)
      else
        word = word.join
        words.push(word)
        word = Array.new
      end
      count = count + 1
    end
    word = word.join
    words.push(word)
    words
  end
end

=begin
li = LineAnalyzer.new("Will it work maybe it will work do you think it will it will", 1)
puts li.content
puts li.highest_wf_words
puts li.highest_wf_count

li = LineAnalyzer.new("Is this Is that that This", 2)
puts li.content
puts li.highest_wf_words
puts li.highest_wf_count
=end

#  Implement a class called Solution. 
class Solution

# Implement the following read-only attributes in the Solution class.
#* analyzers - an array of LineAnalyzer objects for each line in the file
#* highest_count_across_lines - a number with the maximum value for highest_wf_words attribute in the analyzers array.
#* highest_count_words_across_lines - a filtered array of LineAnalyzer objects with the highest_wf_words attribute 
#  equal to the highest_count_across_lines determined previously.

attr_reader :analyzers, :highest_count_across_lines, :highest_count_words_across_lines

def initialize
  @analyzers = []
end


# Implement the following methods in the Solution class.
#* analyze_file() - processes 'test.txt' intro an array of LineAnalyzers and stores them in analyzers.
#* calculate_line_with_highest_frequency() - determines the highest_count_across_lines and 
#  highest_count_words_across_lines attribute values
#* print_highest_word_frequency_across_lines() - prints the values of LineAnalyzer objects in 
#  highest_count_words_across_lines in the specified format


# Implement the analyze_file() method() to:
#* Read the 'test.txt' file in lines 
#* Create an array of LineAnalyzers for each line in the file

def analyze_file()
  @analyzers = []
  count = 1
  File.foreach("test.txt") do |line|
    new_line = LineAnalyzer.new(line,count)  
    @analyzers.push(new_line)
    count += 1
    #puts new_line.content
  end
end

# Implement the calculate_line_with_highest_frequency() method to:
#* calculate the maximum value for highest_wf_count contained by the LineAnalyzer objects in analyzers array
#  and stores this result in the highest_count_across_lines attribute.
#* identifies the LineAnalyzer objects in the analyzers array that have highest_wf_count equal to highest_count_across_lines 
#  attribute value determined previously and stores them in highest_count_words_across_lines.

def calculate_line_with_highest_frequency()
  @highest_count_across_lines = 0
  @highest_count_words_across_lines = []
  count = 0
  @analyzers.each do |line|
    if line.highest_wf_count > @highest_count_across_lines
      @highest_count_across_lines = line.highest_wf_count
    end
    unless line.highest_wf_words == []
      @highest_count_words_across_lines.push(line)
      #puts line.highest_wf_words
    end
  end
  @highest_count_across_lines
end


#Implement the print_highest_word_frequency_across_lines() method to
#* print the values of objects in highest_count_words_across_lines in the specified format

  def print_highest_word_frequency_across_lines()
    puts ("The following words have the highest word frequency per line:")
    @highest_count_words_across_lines.each do |line|
      puts "#{line.highest_wf_words} (appears in line ##{line.line_number})"
    end
  end
end

sol = Solution.new
sol.analyze_file
sol.calculate_line_with_highest_frequency
sol.print_highest_word_frequency_across_lines
