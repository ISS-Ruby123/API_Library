# rubocop:disable Metrics/LineLength, Metrics/BlockLength, Lint/MissingCopEnableDirective
# frozen_string_literal:false

require_relative 'spec_helper.rb'

describe 'Tests LBS API library' do
  VCR.configure do |c|
    c.cassette_library_dir = CASSETTES_FOLDER
    c.hook_into :webmock
  end

  before do
    VCR.insert_cassette CASSETTE_FILE,
                        record: :new_episodes,
                        match_requests_on: %i[method uri headers]
  end

  after do
    VCR.eject_cassette
  end

  describe 'lbs_api.rb' do
    it 'HAPPY : LBS should provide near place information of 500 meters surrounding' do
      LBS::LbsApi.new('AIzaSyC4LirbgvCIiaN5OI0Y8UlDfSOoBOb-7sA')
                 .near_site_list(24.793045, 120.993091, 500).to_yaml.must_equal Test
    end

    it 'BAD : should get error message about Unauthorized when wrong key' do
      proc do
        LBS::LbsApi.new('xxx').near_site_list(24.793045, 120.993091, 500)
      end.must_raise LBS::Response::Unauthorized
    end

    it 'BAD : should get error message about NotFound when wrong geocode' do
      proc do
        LBS::LbsApi.new('AIzaSyC4LirbgvCIiaN5OI0Y8UlDfSOoBOb-7sA')
                   .near_site_list(24.793045, 1120.993091, 500)
      end.must_raise LBS::Response::BadRequest
    end
  end
end
