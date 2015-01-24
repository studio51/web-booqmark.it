source 'https://rubygems.org'

gem 'rails', '4.2.0'
gem 'unicorn'

gem 'mysql2'

gem 'devise'

# Helpers

gem 'slim-rails'
gem 'simple_form'

gem 'json'
# Assets

# gem 'turbolinks'
gem 'execjs'

gem 'sprockets'
gem 'uglifier', '>= 1.3.0'

  # Core

  gem 'jquery-rails'
  gem 'sass-rails', '>= 3.2'

  # Additional

  gem 'bootstrap-sass', '~> 3.3.1'
  # gem 'autoprefixer-rails'
  gem 'font-awesome-rails'
  gem 'will_paginate'

## Bookmark.it ##################
#
# Gems that make Bookmark.it tick
#
#################################

  # Background Jobs
  #
  gem 'sidekiq'

  # Searching and Filtering
  #
  # Searchkick provides a rails interface for elasticsearch
  # TODO: Replace with elasticsearch-rails, elasticsearch-model and replace
  # facets with aggregations
  gem 'searchkick'

  # File upload
  #
  # Used in Bookmark.it for uploading files, notes, images etc.. Paperclip
  # provides the magic for uploading the image and resize it whereas aws sends
  # them to aws s3
  #
  gem 'paperclip'
  gem 'aws-sdk-v1'

  # Image processing
  #
  # Used in Bookmark.it for grabbing a screenshot from the url provided by the
  # user when creating a new Bookmark
  #
  gem 'imgkit'
  gem 'wkhtmltoimage-binary'

  # Bookmarks tags
  #
  # Used for tagging bookmarks
  #
  gem 'acts-as-taggable-on'

group :development do
  # gem 'better_errors'
  # gem 'spring'

  gem 'capistrano-rails'
  gem 'capistrano', '~> 3.2.1'
end
