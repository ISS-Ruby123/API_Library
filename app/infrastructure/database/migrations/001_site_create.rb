# frozen_string_literal: true

require 'sequel'

DB = Sequel.sqlite
DB.create_table :site do
      primary_key :geo_code

      Integer     :lat   , null: false 
      Integer     :lng   , null: false
      String      :name  , null: false
      String      :address , null: false
end