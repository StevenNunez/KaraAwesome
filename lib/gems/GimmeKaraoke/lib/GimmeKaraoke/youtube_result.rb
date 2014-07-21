module GimmeKaraoke
  class YoutubeResult
    attr_reader :song
    def initialize(song)
      @song = song
    end

    def title
      @title ||= song.fetch("title").fetch("$t")
    end

    def url
      @url ||= song.fetch("content").fetch("src")
    end

    def thumbnails
      @thumbnails ||= 1.upto(3).map{|tn| "http://i.ytimg.com/vi/#{uid}/#{tn}.jpg"}
    end

    def embed_url
      @embed_url ||= "//www.youtube.com/embed/#{uid}"
    end

    def uid
      @uid ||= song["id"].fetch("$t").split(':').last
    end

    def attributes
      {
        title: title,
        url: url,
        thumbnails: thumbnails,
        embed_url: embed_url,
        uid: uid
      }
    end
  end
end
