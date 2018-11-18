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
  end
end
