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
      expect(song.title).to match(/karaoke/i)
      expect(song.url).to match(/youtube.com/)
      expect(song.thumbnails).to eq(["http://i.ytimg.com/vi/UU5lmKgyE7U/1.jpg", "http://i.ytimg.com/vi/UU5lmKgyE7U/2.jpg", "http://i.ytimg.com/vi/UU5lmKgyE7U/3.jpg"])
    end

    it "returns nil if there aren't any results" do
      results = nil
      VCR.use_cassette('no_results') do
        results = YoutubeSearch.search('sflkjdsflkjdslkfdjldksj')
      end
      expect(results).to be_nil
    end

    it "returns only songs that allow embedding" do
      pending 'Only return videos that have ["yt$accessControl"] {"action"=>"embed", "permission"=>"allowed"}'
      fail
    end
  end
end
