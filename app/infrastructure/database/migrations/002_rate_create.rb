# frozen_string_literal: true

require 'sequel'
require 'pg'

Sequel.migration do
  change do
    create_table(:rates) do
      primary_key  :id
      foreign_key  :site_id, :sites

      Integer      :rate, unique: false, null: false
      String       :comment, unique: false, null: true

      DateTime :created_date
      DateTime :updated_date
    end
  end
end
