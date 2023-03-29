# Caesar Cipher that takes initial string and outputs modified string per cipher shift factor

def caesar_cipher(string, shift, result = '')
  string.each_char do |char|
    codepoint = char.ord < 91 ? 65 : 97
    # Handles ASCII code to charater conversion for lowercase & uppercase
    if char.ord.between?(65, 90) || char.ord.between?(97, 122)
      encrypter = (((char.ord - codepoint) + shift) % 26) + codepoint
      result += encrypter.chr
    # Handles string destruction and reconstruction, as well as, keeps punctuation & spaces of original string
    else
      result += char
    end
  end
  # Handles encryption error message based on shift input that wraps to original string
  if shift == 26
    error_message(string)
  else
    result
  end
end

def error_message(string)
  "Encryption not completed: #{string}"
end

puts caesar_cipher("hello", 5)
