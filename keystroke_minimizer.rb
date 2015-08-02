# When typing on a phone keyboard, the OS should try to minimize the number of keystrokes required for typing.  To achieve this goal, your phone company is going to put together a dictionary of the common words that a user may type. The goal is to reduce the average number of keystrokes needed to type words that are in the dictionary. During the typing of a word, whenever the following letter is uniquely determined, the cellphone system will input it automatically, without the need for a keystroke. To be more precise, the behavior of the cellphone system will be determined by the following rules:
# The system never guesses the first letter of a word, so the first letter always has to be input manually by pressing the corresponding key.
# If a non-empty succession of letters c1c2...cn has been input, and there is a letter c such that every word in the dictionary which starts with c1c2...cn also starts with c1c2...cnc, then the system inputs c automatically, without the need of a keystroke. Otherwise, the system waits for the user.
# For instance, if the dictionary is composed of the words `hello', `hell', `heaven' and `goodbye', and the user presses `h', the system will input `e' automatically, because every word which starts with `h' also starts with `he'. However, since there are words that start with `hel' and with `hea', the system now needs to wait for the user. If the user then presses `l', obtaining the partial word `hel', the system will input a second `l' automatically. When it has `hell' as input, the system cannot guess, because it is possible that the word is over, or it is also possible that the user may want to press `o' to get `hello'. In this fashion, to type the word `hello' the user needs three keystrokes, `hell' requires two, and `heaven' also requires two, because when the current input is `hea' the system can automatically input the remainder of the word by repeatedly applying the second rule. Similarly, the word `goodbye' needs just one keystroke, because after pressing the initial `g' the system will automatically fill in the entire word.  If the user enters a word that isn’t in the dictionary, the dictionary will be used to predict input as much as possible.  For instance, `hellfire' needs six keystrokes (h, l, f, i, r, e).
# Your task is, given a dictionary and a list of words to be typed, to calculate the number of keystrokes required to type each input word.

words =  ['hello', 'hell', 'heaven', 'goodbye']

class KeystrokeMinimizer
  attr_reader :trie


  def initialize(words)
    @trie = {}

    words.each do |word|
      insert_string(trie, word)
    end
  end

  def minimum_keystrokes(word)
    key_strokes = 0
    current = trie
    word.each_char.each_with_index do |char, index|
      if current.keys.size > 1
        key_strokes += 1
      end

      if current[char]
        current = current[char]
      else
        insert_string(current, word[index..-1])
        return key_strokes + ((word.length - 1) - index)
      end
    end

    key_strokes
  end

  def insert_string(current, word)
    word.each_char do |char|
      current[char] ||= {}
      current = current[char]
    end

    current[:word] = true
  end
end

minimizer = KeystrokeMinimizer.new(words)

# puts minimizer.trie
puts minimizer.minimum_keystrokes('goodbye')
puts minimizer.minimum_keystrokes('hello')
puts minimizer.minimum_keystrokes('hell')
puts minimizer.minimum_keystrokes('heaven')
puts minimizer.minimum_keystrokes('hellfire')
puts minimizer.minimum_keystrokes('hellfire')

puts minimizer.trie
