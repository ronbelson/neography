require 'rails'

class Railtie < Rails::Railtie 

  rake_tasks do
    load "neography/tasks.rb"
  end  
end