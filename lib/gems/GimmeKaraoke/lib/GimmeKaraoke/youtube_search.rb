module GimmeKaraoke
  YoutubeResult = Struct.new(:title, :url, :thumbnails, :embed_url)
  class YoutubeSearch
    def initialize(raw_query)
      @raw_query = raw_query
    end

    def query
      @query ||= karaokeize(escape(@raw_query))
    end

    def search
      results = run_query(query)
      return nil unless results["feed"]['entry']
      items(results["feed"]['entry'])
    end

    def self.search(query)
      new(query).search
    end

    private

    def items(result)
      result.map do |song|
        item(song)
      end
    end

    def item(song)
      title = get_title(song)
      url = get_url(song)
      thumbnails = get_thumbnails(song)
      embed_url = get_embed_url(song)
      YoutubeResult.new(title, url, thumbnails, embed_url)
    end

    def run_query(query)
      res = RestClient.get("https://gdata.youtube.com/feeds/api/videos?q=#{query}&alt=json&v=2")
      JSON.parse(res)
    end

    def get_title(song)
      song.fetch("title").fetch("$t")
    end

    def get_url(song)
      song.fetch("content").fetch("src")
    end

    def get_thumbnails(song)
      song_id = song["id"].fetch("$t").split(':').last
      1.upto(3).map{|tn| "http://i.ytimg.com/vi/#{song_id}/#{tn}.jpg"}
    end

    def get_embed_url(song)
      song_id = song["id"].fetch("$t").split(':').last
      "//www.youtube.com/embed/#{song_id}"
    end

    def karaokeize(query)
      query + '+Karaoke'
    end

    def escape(query)
      query.gsub(/\s/, "+")
    end
  end
end
