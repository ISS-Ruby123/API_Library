# frozen_string_literal: true

require 'sequel'
require 'pg'

Sequel.migration do
  change do
    create_table(:comments) do
      primary_key  :id
      foreign_key  :site_id, :sites

      String       :feedback, unique: false, null: false

      DateTime :created_date
      DateTime :updated_date
    end
  end
end
