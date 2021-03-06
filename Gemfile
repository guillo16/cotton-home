source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.6.5"

gem "rails", "~> 6.0.3", ">= 6.0.3.4"

gem "autoprefixer-rails", "~> 9.8", ">= 9.8.6.1"
gem "bootsnap", ">= 1.4.2", require: false
gem "cloudinary", "~> 1.16.0"
gem "devise", "~> 4.7", ">= 4.7.2"
gem "friendly_id", "~> 5.4.0"
gem "font-awesome-sass"
gem "jbuilder", "~> 2.7"
gem "money-rails", "~>1.12"
gem 'mail_form', '~> 1.9'
gem "pg", ">= 0.18", "< 2.0"
gem "puma", "~> 4.1"
gem "redis", "~> 4.0"
gem "sass-rails", ">= 6"
gem "simple_form", "~> 5.0", ">= 5.0.2"
gem "turbolinks", "~> 5"
gem "turbolinks_render"
gem "webpacker", "~> 4.0"
gem "will_paginate", "~> 3.1.0"
gem "will_paginate-bootstrap4"
gem 'mercadopago-sdk', '~> 1.3'
gem 'letter_opener', group: :development

group :development, :test do gem "pry-byebug"
  gem "pry-rails"
  gem "dotenv-rails"

  # Call "byebug" anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling "console" anywhere in the code.
  gem "web-console", ">= 3.3.0"
  gem "listen", "~> 3.2"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
  # Easy installation and use of web drivers to run system tests with browsers
  gem "webdrivers"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
