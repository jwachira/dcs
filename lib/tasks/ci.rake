task :cruise => ["ci:all"]

namespace :ci do
  desc "full build with metrics"
  task :all => [:run_tests]
  # task :all => [:run_tests]

  task :environment do
    p "Build started => #{DateTime.now}"
    sh "git submodule update --init"
    if ci_host?
      ENV["PATH"] = "/usr/local/ruby-enterprise/bin:#{ENV["PATH"]}"
      sh "[ -e config/database.yml ] || cp config/database.example.yml config/database.yml"
      p "database.yml created"
    end
  end
  
  task :install_gems do
    p "installing gems"
    sh "sudo rake gems:install"
    sh "sudo rake gems:install RAILS_ENV=test"
    p "done installing gems"
  end
  
  task :run_tests => [:environment, :install_gems, "db:create:all", "db:migrate", "db:test:prepare"] do
    p "ready to run tests"
    Rake::Task["test"].invoke
    p "done tests"
  end
    
  def ci_host?
    ENV["HOST"].nil? || ( ENV["HOST"].match(/ci/) && ENV["HOST"].match(/ruby/) )    
  end
end #namspace :ci
