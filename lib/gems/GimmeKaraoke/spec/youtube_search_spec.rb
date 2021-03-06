require 'spec_helper'

module GimmeKaraoke
  describe YoutubeSearch do
    it 'cleans song query' do
      ys = YoutubeSearch.new('Beastie Boys Sabotage')
      expect(ys.query).to eq('Beastie+Boys+Sabotage+Karaoke')
    end

    it "returns list of youtube results" do
      results = nil
      VCR.use_cassette('video_search') do
        results = YoutubeSearch.search("Beastie Boys Sabotage")
      end
      song = results.first
      expect(song.uid).to eq('UU5lmKgyE7U')
      expect(song.title).to match(/karaoke/i)
      expect(song.url).to match(/youtube.com/)
      expect(song.thumbnails).to eq(["http://i.ytimg.com/vi/UU5lmKgyE7U/1.jpg", "http://i.ytimg.com/vi/UU5lmKgyE7U/2.jpg", "http://i.ytimg.com/vi/UU5lmKgyE7U/3.jpg"])
      expect(song.embed_url).to eq('//www.youtube.com/embed/UU5lmKgyE7U')
    end

    it "returns attributes" do
      results = nil
      VCR.use_cassette('video_search') do
        results = YoutubeSearch.search("Beastie Boys Sabotage")
      end
      song = results.first
      attributes = {
        :title=>"Beastie Boys - Sabotage Karaoke",
        :url=>"https://www.youtube.com/v/UU5lmKgyE7U?version=3&f=videos&app=youtube_gdata",
        :thumbnails=>["http://i.ytimg.com/vi/UU5lmKgyE7U/1.jpg", "http://i.ytimg.com/vi/UU5lmKgyE7U/2.jpg", "http://i.ytimg.com/vi/UU5lmKgyE7U/3.jpg"],
        :embed_url=>"//www.youtube.com/embed/UU5lmKgyE7U",
        :uid=>"UU5lmKgyE7U"
        }
      expect(song.attributes).to eq(attributes)
    end

    it "returns nil if there aren't any results" do
      results = nil
      VCR.use_cassette('no_results') do
        results = YoutubeSearch.search('sflkjdsflkjdslkfdjldksj')
      end
      expect(results).to be_nil
    end

    it "returns only songs that allow embedding" do
      results = nil
      VCR.use_cassette('restricted_video') do
        results = YoutubeSearch.search('single ladies')
      end

      expect(results.count).to be(23)
    end
  end
end
