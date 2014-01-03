COLOR = [0x00, 0x5F, 0x87, 0xAF, 0xD7, 0xFF]

GREY = [
  0x08, 0x12, 0x1C, 0x26,
  0x30, 0x3A, 0x44, 0x4E,
  0x58, 0x62, 0x6C, 0x76,
  0x80, 0x8A, 0x94, 0x9E,
  0xA8, 0xB2, 0xBC, 0xC6,
  0xD0, 0xDA, 0xE4, 0xEE]

TERM_16COLOR = [
  '#000000', '#FF0000', '#00FF00', '#FFFF00',
  '#0000FF', '#FF00FF', '#00FFFF', '#FFFFFF',
  '#808080', '#800000', '#008000', '#808000',
  '#000080', '#800080', '#008080', '#C0C0C0']

class String
  def to_color_num
    unless /#\h{6}/ =~ self
      raise "invalid rgb"
    end

    rgb = self.upcase

    if TERM_16COLOR.include?(rgb)
      return TERM_16COLOR.index(rgb)
    else
      hexes = rgb[1..2].hex, rgb[3..4].hex, rgb[5..6].hex
      if hexes[0] == hexes[1] and hexes[0] == hexes[2]
        return 232 + GREY.index(GREY.min_by {|grey| (grey - hexes[0]).abs})
      else
        idxs = hexes.map {|hex|
          COLOR.min_by {|color| (color - hex).abs}
        }.map {|min|
          COLOR.index min
        }
        return 36 * idxs[0] + 6 * idxs[1] + idxs[2] + 16
      end
    end
  end
end

class Fixnum
  def to_rgb
    convert_color_cube = lambda {|color_num|
      color_num -= 16
      r, mod = color_num.divmod(36)
      g, b = mod.divmod(6)
      [COLOR[r], COLOR[g], COLOR[b]].map {|v|
        (v <= 0x0F) ? "0".concat(v.to_s(16)) : v.to_s(16)
      }.join.upcase
    }

    if self > 255 and self < 0
      raise "terminal rgb code is 0 to 255"
    end

    case self
    when 0..15
      TERM_16COLOR[self]
    when 16..231
      '#'.concat convert_color_cube.call(self)
    when 232..255
      '#'.concat (GREY[self - 232].to_s(16) * 3).upcase
    end
  end
end

class HighLight
  attr_accessor :group, :guifg, :guibg, :gui
  attr_accessor :cterm, :ctermfg, :ctermbg, :term

  def generate_cterm
    if @ctermfg
      if /#\h{6}/ =~ @ctermfg
        tmp = @ctermfg.to_color_num
        @ctermfg = tmp
      end
    else
      if @guifg and @guifg != 'NONE'
        @ctermfg = @guifg.to_color_num
      end
    end
    if @ctermbg
      if /#\h{6}/ =~ @ctermbg
        tmp = @ctermbg.to_color_num
        @ctermbg = tmp
      end
    else
      if @guibg and @guibg != 'NONE'
        @ctermbg = @guibg.to_color_num
      end
    end
  end

  def to_vim
    generate_cterm
    arr = ["hi"]
    self.instance_variables.each do |name|
      key = name.to_s.slice(1..-1)
      if key == 'group'
        arr << "#{self.instance_variable_get name}"
      else
        arr << "#{key}=#{self.instance_variable_get name}"
      end
    end
    return arr.join(' ')
  end
end

class Link
  attr_accessor :from, :to, :default

  def to_vim
    arr = ["hi!"]
    arr << 'default' if self.default
    arr << 'link'
    arr << self.from
    arr << self.to
    return arr.join(' ')
  end
end

$items = []

def parse(fname)
  File.open(fname, 'r') do |f|
    f.readlines.each do |line|
      # remove comment
      next if line.match(/^\s*"|^\r|^\n/)
      line.gsub!(/".*/, '')

      words = line.split(' ')
      cmd = words.shift
      case cmd
      when 'link'
        $items << parse_link(words)
      when 'group'
        group = words.shift
        $items << parse_highlight(group, words)
      else
        $items << line.chomp
      end
    end
  end
end

def parse_link(words)
  link = Link.new
  link.from = words[0]
  link.to = words[1]
  if words[2] == 'default'
    link.default = true
  else
    link.default = false
  end
  return link
end

def parse_highlight(group, words)
  hi = HighLight.new
  hi.group = group
  words.each do |word|
    key, val = word.split('=')
    case key
    when 'gfg' then hi.guifg = val
    when 'gbg' then hi.guibg = val
    when 'gui' then hi.gui = val
    when 'term' then hi.term = val
    when 'cterm' then hi.cterm = val
    when 'cfg' then hi.ctermfg = val
    when 'cbg' then hi.ctermbg = val
    end
  end
  return hi
end

def write(oname)
  File.open(oname, "w") do |f|
    f.write ($items.map {|hi|
      if hi.is_a? String
        hi
      else
        hi.to_vim
      end
    }).join("\n")
  end
end

parse 'aiko.txt'
write 'colors/aiko.vim'
