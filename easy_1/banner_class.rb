# banner_class.rb

class Banner
  def initialize(message, width = nil)
    min_width = message.size + 4

    if width.nil? || width < min_width
      width = min_width
    end

    @message = message
    @width = width
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  def horizontal_rule
    "+#{'-' * (@width - 2) }+"
  end

  def empty_line
    "|#{' ' * (@width - 2) }|"
  end

  def message_line
    "|#{@message.center(@width - 2)}|"
  end
end

banner = Banner.new('To boldly go where no one has gone before.')
puts banner

banner = Banner.new('')
puts banner