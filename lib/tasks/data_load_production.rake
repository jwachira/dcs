namespace :data do
  namespace :load do
    namespace :production do
      
      task :all => %w(environment data:load:default:all) + %w().map{ |task| "data:load:production:#{task}"}
      
    end #namespace :default
  end #namespace :load
end #namspace :date