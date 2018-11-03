# frozen_string_literal: true

%w[lib].each do |folder|
  require_relative "#{folder}/init.rb"
end
