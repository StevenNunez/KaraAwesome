module GimmeKaraoke
  YoutubeResult = Struct.new(:title, :url, :thumbnails, :embed_url, :uid)
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
        YoutubeResult.new(song)
      end
    end

    def run_query(query)
      res = RestClient.get("https://gdata.youtube.com/feeds/api/videos?q=#{query}&alt=json&v=2")
      JSON.parse(res)
    end

    def karaokeize(query)
      query + '+Karaoke'
    end

    def escape(query)
      query.gsub(/\s/, "+")
    end
  end
end
