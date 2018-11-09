# frozen_string_literal: true

require 'sequel'

DB = Sequel.sqlite
DB.create_table :site do
  primary_key :geo_code
  Float     :lat, null: false
  Float     :lng, null: false
  String      :name, null: false
  String      :address, null: false
end
