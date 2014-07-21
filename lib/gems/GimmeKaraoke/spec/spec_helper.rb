$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'vcr'
require 'GimmeKaraoke'

VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.hook_into :webmock # or :fakeweb
end
