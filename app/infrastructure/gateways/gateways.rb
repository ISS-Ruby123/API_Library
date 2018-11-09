# frozen_string_literal:false

require 'http'
require 'yaml'
require_relative 'pipeline.rb'

# LBS service api module
module Gateways
  include Pipeline
  # Class for Location based service API
  class SiteApi
    def initialize(token)
      @token = token
    end

    def near_site_list(lat, lng, distance)
      Request.new(@token).near_sites(lat, lng, distance)
    end

    def geocode_of(addr)
      Request.new(@token).geocode(addr)
    end
  end

  # Class for Request
  class Request
    GEOCODE_PATH = 'https://maps.googleapis.com/maps/api/geocode/json?'.freeze
    NEARBY_PATH = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?'.freeze

    def initialize(token, cache = {})
      @token = token
      @cache = cache
    end

    def near_sites(lat, lng, distance)
      location_argv = ['location=%f,%f', 'radius=%d', 'key=%s'].join('&')
      url = format(NEARBY_PATH + location_argv, lat, lng, distance, @token)
      Pipeline::Locater.new(url).all_sites if response_code(url) == 200
    end

    def geocode(addr)
      location_argv = ['address=%s', 'key=%s'].join('&')
      url = format(GEOCODE_PATH + location_argv, addr, @token)
      Pipeline::Locater.new(url).site_geo if response_code(url) == 200
    end

    def response_code(url)
      code = get_status(url)
      Response.new(code).tap do |api_response|
        raise(api_response.error) unless api_response.successful?
      end
      code
    end

    def get_status(url)
      @cache.fetch(url) do
        Pipeline::HttpObject.new(url).status?
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
