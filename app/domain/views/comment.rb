# frozen_string_literal: true

module Views
    # View for a single contributor
    class Comments
      def initialize(comment)
        @comment = comment
      end
  
      def entity
        @comment
      end
  
      def site_id
        @comment[0][:id]
      end
  
      def comment
        @comment[0][:feedback]
      end
    end
  end