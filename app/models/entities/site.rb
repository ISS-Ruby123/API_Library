# frozen_string_literal: true

require_relative 'init.rb'

module Entity
  # Class Site
  class Site < Dry::Struct
    include Dry::Types.module
    attribute :site, Strict::Array
    # attribute :address,Strict::String.optional
    # attribute :location,Strict::String.optional
    # attribute :typeof,Strict::String.optional
    # attribute :name,Strict::String.optional
  end
end
