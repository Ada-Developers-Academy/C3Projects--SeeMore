module WelcomeHelper
  def shorten(some_long_text) # FIXME: test this method!
    if some_long_text.length > 425
      return some_long_text[0,425] + "..."
    else
      return some_long_text
    end
  end
end
