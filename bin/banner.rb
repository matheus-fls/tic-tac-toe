# frozen_string_literal: false

# Holds the scan lines for one character
class Character
  def initialize
    # Strings to represent the character
    @scan_lines = []
  end

  # Receives one line for the character representation
  # and pushes it to the scan lines
  def push(line)
    @scan_lines << line
  end

  # Gets the scan line at 'index' for the character
  def get(index)
    @scan_lines[index]
  end

  # Just return this character as an string (for debug purposes)
  def to_s
    @scan_lines.join("\n")
  end
end

# Holds a series of scan lines for zero or more characters
class Banner
  # Takes the height of each line and an optional initial group of scan lines
  def initialize(height, lines = Array.new(height, ''))
    @height = height
    @lines = lines
  end

  # Receives an instance of Char and appends the scan lines from it to the
  # current scan lines for this banner. Returns a new instance of Banner
  # holding the new scanlines
  def add(char)
    Banner.new(@height, @lines.map.with_index { |line, idx| line + char.get(idx) })
  end

  # Returns all the appended scan lines separated by a new line.
  def to_s
    @lines.join("\n")
  end
end

# Holds the alphabet characters, reads the input and generates banners
class Alphabet
  @@ALPHABET = [ # rubocop:disable Style/ClassVars, Naming/VariableName
    # 234567123456712345671234567123456712345671234567123456712345671234567123456712345671234567
    '                                                                                #          ', # 1
    '  ###   #   #    #     ###   #####     #   #####    ##   #####   ###    ###     #          ', # 2
    ' #   #  #   #   ##    #   #     #     ##   #       #         #  #   #  #   #    #          ', # 3
    ' #   #   # #     #        #    #     # #   ####   #         #   #   #  #   #    #          ', # 4
    ' #   #    #      #       #      #   #  #       #  ####     #     ###    ####    #          ', # 5
    ' #   #   # #     #      #        #  #####      #  #   #    #    #   #      #    #          ', # 6
    ' #   #  #   #    #     #     #   #     #   #   #  #   #    #    #   #     #     #          ', # 7
    '  ###   #   #   ###   #####   ###      #    ###    ###     #     ###    ##      #          ', # 8
    '                                                                                #          ' #  9
  ]

  def initialize(width = 7, height = 9)
    @width = width
    @height = height
    @chars = {}
    'OX123456789| '.split('').map { |ch| @chars[ch] = Character.new }

    @@ALPHABET.each do |row|
      @chars.each do |_, char|
        char.push row[0..@width - 1]
        row = row[@width..-1]
      end
    end
  end

  # Takes some string and creates a banner by appending each character scan lines
  # to a banner. Each character appended creates a new banner.
  def to_banner(text)
    banner = Banner.new(@height)
    text.upcase.split('').each do |ch|
      banner = banner.add(@chars[@chars[ch] ? ch : '?'])
    end
    banner
  end
end
