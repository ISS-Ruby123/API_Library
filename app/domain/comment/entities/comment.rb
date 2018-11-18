# frozen_string_literal: true

require_relative 'init.rb'

module Entity
  # class Site
  class CommentEntity < Dry::Struct
    include Dry::Types.module

    attribute :site_id, Integer.optional
    attribute :feedback, String.optional

    def to_attr_hash
      to_hash.reject { |key, _| [:id].include? key }
    end
  end
end
