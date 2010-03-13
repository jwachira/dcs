# Helpful note, you need to run 
# bundle unlock 
# from the command line before editing this file and
# bundle lock 
# after

source :gemcutter
source 'http://gems.github.com'

gem 'rails',              '2.3.5',  :require => nil
gem 'rack',               '1.0.1'
gem 'mysql',              :bundle => false

gem 'authlogic',                       '2.1.3'
gem 'formtastic',                      '0.9.7', :require => nil
gem 'declarative_authorization',       '0.4'
gem 'paperclip',                       '2.3.1.1'
 
group :development do
  gem 'ruby-debug'
  gem 'ruby-debug-base'
end

group :test do
  # gem 'rspec',            '1.2.8',   :require => 'spec'
  # gem 'rspec-rails',      '1.2.7.1', :require => nil
  # gem 'remarkable_rails', '3.1.11',  :require => nil
  # gem 'remarkable',       '3.1.11'
end

group :metrics do
  gem 'bundler',                         '0.9.7'
  gem 'relevance-rcov',   '0.9.0',    :require => 'rcov'
  gem 'metric_fu'
  gem 'churn'
  gem 'Saikuro'
  gem 'flay', '1.4.0'
  gem 'flog', '2.2.0'
  gem 'reek', '1.2.7.1'
  gem 'roodi', '2.1.0'
end
