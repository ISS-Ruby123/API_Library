# frozen_string_literal: true

require 'roda'
require 'slim'
require_relative '../domain/site/mappers/site_mapper.rb'

# module of controller
module Controller
  include Mapper
  # Web App
  class App < Roda
    plugin :render, engine: 'slim', views: 'app/views'
    plugin :assets, path: 'app/views/assets',
                    css: 'style.css', js: 'table_row.js'
    plugin :halt
    plugin :flash

    route do |routing|
      routing.assets # load CSS

      # GET /
      routing.root do
        view 'home'
      end

      routing.on 'show_site' do
        routing.get do
          lat = 24.793045
          lng = 120.993091
          radius = 500
          near_sites = SiteMapper.new('../../config/secrets.yml')
                                 .load_near_site_list(lat, lng, radius)

          # Show viewer the toilet site
          view 'show_site', locals: { site: near_sites }
        end
      end
    end
  end
end
