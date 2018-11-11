# frozen_string_literal: true

require 'sequel'

module Site
  module Database
    # Object-Relational Mapper for Members
    class CommentOrm < Sequel::Model(:comments)
      many_to_one :site,
                  class: :'Site::Database::SiteOrm'

      plugin :timestamps, update_on_create: true
    end
  end
end
