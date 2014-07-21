module GimmeKaraoke
  class SongQuery
    attr_reader :source, :raw_query
    def initialize(raw_query, source: :youtube)
      @raw_query = raw_query
      @source = source
    end

    def search
      sources[source].search(raw_query)
    end

    def self.search(query)
      new(query).search
    end

    private

    def sources
      {
        youtube: YoutubeSearch
      }
    end
  end
end
