require './lib/caesar_cipher'

describe "#caesar_cipher" do
  it "takes initial string and outputs modified string per cipher shift factor" do
    expect(caesar_cipher("What a string!", 5)).to eql("Bmfy f xywnsl!")
  end

  it "shifts the string to the right by 3 characters" do
    expect(caesar_cipher("hello", 3)).to eql("khoor")
  end

  it "shifts the string to the left by 5 characters" do
    expect(caesar_cipher("world", -5)).to eql("rjmgy")
  end

  it "handles uppercase and lowercase characters" do
    expect(caesar_cipher("Hello World", 5)).to eql("Mjqqt Btwqi")
  end

  it "keeps punctuation and spaces of the original string" do
    expect(caesar_cipher("Hello, World!", 7)).to eql("Olssv, Dvysk!")
  end

  it "handles a shift of 26, printing an error message and returning the original string" do
    expect(caesar_cipher("hello", 26)).to eql("Encryption not completed: hello")
  end

  it "handles an empty string input" do
    expect(caesar_cipher("", 7)).to eql("")
  end
end
