set :application, 'shame'
set :repo_url, 'git@github.com:davinov/shame.git'

set :branch, 'staging'

set :deploy_to, '/var/www/shame.nowinsky.net'
set :scm, :git

set :format, :pretty
# set :log_level, :debug
set :pty, true

set :linked_files, %w{config/default.coffee config/production.coffee}
set :linked_dirs, %w{node_modules bower_components}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      within "#{release_path}" do
        execute :npm, 'stop'
        execute :npm, 'start'
      end
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :finishing, 'deploy:cleanup'

end
