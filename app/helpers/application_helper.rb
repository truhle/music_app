module ApplicationHelper

  include ERB::Util

  def ugly_lyrics(lyrics)
    lyrics = sanitize(lyrics)
    lyrics_ary = lyrics.split("\n").map {|line| line.length > 1 ? "&#9835 " + line : line}
    formatted_lyrics = "<pre>" + lyrics_ary.join + "</pre>"
    formatted_lyrics.html_safe
  end
end
