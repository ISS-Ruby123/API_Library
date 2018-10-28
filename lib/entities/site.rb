require_relative 'init.rb'

module Entity
    class Site < Dry::Struct
        include Dry::Types.module
        attribute :site,Strict::Array
        # attribute :address,Strict::String.optional
        # attribute :location,Strict::String.optional
        # attribute :typeof,Strict::String.optional
        # attribute :name,Strict::String.optional
        
    end
end