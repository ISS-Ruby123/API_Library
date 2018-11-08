# frozen_string_literal: true

require_relative 'init.rb'

module Entity
  # class Site
  class SiteEntity < Dry::Struct
    include Dry::Types.module
    attribute :sites, Strict::Array
    attribute :address, Strict::Array.optional
    attribute :location, Strict::Array.optional
    attribute :latitude, Strict::Array.optional
    attribute :longitude, Strict::Array.optional
    attribute :type, Strict::Array.optional
    attribute :name, Strict::Array.optional
    attribute :name_addr, Strict::Array.optional
  end
end
