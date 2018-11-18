# frozen_string_literal: true

require_relative '../../../infrastructure/database/orms/comment_orm.rb'

<<<<<<< HEAD

=======
>>>>>>> b2edd6cffba602482e9be6db4466e9b9e6d6a2b6
module Comment
  module Repository
    # Repository for Comment Entities
    class Comments
      # Insert a new record to the comments table
      # param: site_id: [integer] record index of site in site table
      # param: feedback: [string] comment for the site
      def self.insert(site_id, feedback)
        Database::CommentOrm.insert(site_id: site_id, feedback: feedback)
      end

      # Find all records of the comments table
      # return: array of all records
      def self.all
        Database::CommentOrm.all
      end

      # Find value of column 'id' by filtering column 'site_id'
      # param: site_id: [integer] the record index of the site
      # return: array of target records
      def self.find_id_by_siteid(site_id)
        Database::CommentOrm.where(site_id: site_id).all
      end
    end
  end
end
