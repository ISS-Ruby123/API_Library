# frozen_string_literal: true

require_relative '../entities/comment.rb'
require_relative '../../../infrastructure/database/orms/comment_orm.rb'

module Comment
  module Repository
    # Repository for Comment Entities
    class Comments
      # Insert a new record to the comments table
      # param: site_id: [integer] record index of site in site table
      # param: feedback: [string] comment for the site
      def self.insert(site_id, feedback)
        Site::Database::CommentOrm.insert(site_id: site_id, feedback: feedback)
      end

      # Find all records of the comments table
      # return: array of all records
      def self.all
        Site::Database::CommentOrm.all
      end

      # Find value of column 'id' by filtering column 'site_id'
      # param: site_id: [integer] the record index of the site
      # return: array of target records
      def self.find_id_by_siteid(site_id)
        Site::Database::CommentOrm.where(site_id: site_id).all
      end
    end
  end
end
