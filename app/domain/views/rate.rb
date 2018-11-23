# frozen_string_literal: true

module Views
  # View for sites
  class Rate
    def initialize(rate)
      @rate = rate
    end

    def entity
      @rate
    end
  end
end
