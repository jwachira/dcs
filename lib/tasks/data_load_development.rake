namespace :data do
  namespace :load do
    namespace :development do
      
      task :all => %w(environment data:load:default:all) + %w().map{ |task| "data:load:development:#{task}"}
      
    end #namespace :default
  end #namespace :load
end #namspace :date