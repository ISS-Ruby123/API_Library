# frozen_string_literal:false

require 'http'
require 'yaml'

# LBS service api module
module LBS
  include GeoHandler
  # Class for Location based service API
  class LbsApi
    def initialize(token)
      @token = token
    end

    def near_site_list(lat, lng, distance)
      Request.new(@token).near_sites(lat, lng, distance)
    end
  end

  # Class for Request
  class Request
    GEOCODE_PATH = 'https://maps.googleapis.com/maps/api/geocode/json?'
    NEARBY_PATH = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?'

    def initialize(token, cache = {})
      @token = token
      @cache = cache
    end

    def near_sites(lat, lng, distance)
      location_argv = ['location=%f,%f', 'radius=%d', 'key=%s'].join('&')
      url = format(NEARBY_PATH + location_argv, lat, lng, distance, @token)
      search(url)
    end

    def search(url)
      response_code = get_status(url)

      Response.new(response_code).tap do |api_response|
        raise(api_response.error) unless api_response.successful?
      end

      GeoHandler::Locater.new(url).all_sites if response_code == 200
    end

    def get_status(url)
      @cache.fetch(url) do
        # GeoHandler::Locater.new(url).status?
        GeoHandler::HttpObject.new(url).status?
      end
    end
  end

  # Class for Response
  class Response
    # response if arguments of api is not good
    BadRequest = Class.new(HTTP::Error)
    # response if without key or wrong key
    Unauthorized = Class.new(StandardError)
    # response if not found return
    NotFound = Class.new(StandardError)

    HTTP_ERROR = {
      400 => BadRequest,
      401 => Unauthorized,
      404 => NotFound
    }.freeze

    def initialize(code)
      @code = code
    end

    def successful?
      HTTP_ERROR.key?(@code) ? false : true
    end

    def error
      HTTP_ERROR[@code]
    end
  end
end
