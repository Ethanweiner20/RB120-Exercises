# Banner Class

class Banner
  MARGIN = 2
  MAX_WIDTH = 80

  def initialize(message, width = nil)
    @message = message
    @width = valid_width?(width, message) ? width : default_width(message)
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  attr_reader :message, :width

  def valid_width?(width, message)
    width && width <= MAX_WIDTH && width >= default_width(message)
  end

  def default_width(message)
    message.length + 2 * MARGIN
  end

  def horizontal_rule
    "+#{'-' * (width - 2)}+"
  end

  def empty_line
    "|#{' ' * (width - 2)}|"
  end

  def message_line
    '|' + message.center(width - 2) + '|'
  end
end

banner = Banner.new('To boldly go where no one has gone before.')
puts banner

=begin
+--------------------------------------------+
|                                            |
| To boldly go where no one has gone before. |
|                                            |
+--------------------------------------------+
=end

# Valid width
banner = Banner.new('To boldly go where no one has gone before.', 60)
puts banner

# Not enough width
banner = Banner.new('To boldly go where no one has gone before.', 20)
puts banner

banner = Banner.new('')
puts banner

=begin
+--+
|  |
|  |
|  |
+--+
=end

banner = Banner.new('', 20)
puts banner