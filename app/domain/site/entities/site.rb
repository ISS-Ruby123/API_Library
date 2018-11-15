# frozen_string_literal: true

require_relative 'init.rb'

module Entity
  # class Site
  class SiteEntity < Dry::Struct
    include Dry::Types.module
    attribute :name, Strict::Array.optional
    attribute :address, Strict::Array.optional
    attribute :lat, Strict::Array.optional
    attribute :lng, Strict::Array.optional
    # attribute :sites, Strict::Array
    # attribute :type, Strict::Array.optional
    # attribute :location, Strict::Array.optional
    # attribute :name_addr, Strict::Array.optional
  end
end
