# frozen_string_literal: true

require 'sequel'
require 'pg'

Sequel.migration do
  change do
    create_table(:sites) do
      primary_key  :id
      String       :name, null: false
      String       :address, null: false
      Float        :lat, null: false
      Float        :lng, null: false
      String       :geocode, unique: true, null: false

      DateTime     :created_date
      DateTime     :updated_date
    end
  end
end
