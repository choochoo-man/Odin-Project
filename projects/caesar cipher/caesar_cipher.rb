
ALPHABET_LOWERCASE = ("a".."z").to_a
ALPHABET_UPPERCASE = ("A".."Z").to_a

def caesar_cipher(string, shift)
  letter_array = string.split("")
  shifted_array = letter_array.map do |letter, index|
    alphabet = is_upcase?(letter) ? ALPHABET_UPPERCASE : ALPHABET_LOWERCASE
    first_index = alphabet.index(letter)
    shifted_index = (first_index.to_i + shift.to_i) % 26
    
    alphabet[shifted_index]
  end

  shifted_array.join
end

def is_upcase?(character)
  character == character.upcase
end
