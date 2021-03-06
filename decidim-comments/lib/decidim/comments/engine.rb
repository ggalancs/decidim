# frozen_string_literal: true
require "rails"
require "active_support/all"

require "decidim/core"
require "jquery-rails"
require "sassc-rails"
require "foundation-rails"
require "foundation_rails_helper"
require "autoprefixer-rails"

require "decidim/comments/query_extensions"
require "decidim/comments/mutation_extensions"

module Decidim
  module Comments
    # Decidim's core Rails Engine.
    class Engine < ::Rails::Engine
      isolate_namespace Decidim::Comments

      initializer "decidim_comments.assets" do |app|
        app.config.assets.precompile += %w(decidim_comments_manifest.js)
      end

      initializer "decidim_comments.query_extensions" do
        Comments::QueryExtensions.extend!(Decidim::Api::QueryType)
      end

      initializer "decidim_comments.mutation_extensions" do
        Comments::MutationExtensions.extend!(Decidim::Api::MutationType)
      end

      initializer "decidim.stats" do
        Decidim.stats.register :comments_count, priority: StatsRegistry::MEDIUM_PRIORITY do |features, start_at, end_at|
          Decidim.feature_manifests.sum do |feature|
            feature.stats.filter(tag: :comments).with_context(features, start_at, end_at).map { |_name, value| value }.sum
          end
        end
      end
    end
  end
end
