module Paperclip
  def self.run(cmd, params = '', expected_outcodes = 0)
    case cmd
    when 'identify'
      '100x100'
    when 'convert'
      return
    else
      super
    end
  end
end

class Paperclip::Attachment
  def post_process
  end
end
