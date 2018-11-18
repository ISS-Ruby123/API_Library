# frozen_string_literal: true

folders = %w[site comment]
folders.each do |folder|
  require_relative "#{folder}/init.rb"
end
