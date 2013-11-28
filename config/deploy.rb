set :application, 'shame'
set :repo_url, 'git@github.com:davinov/shame.git'

set :branch, 'staging'

set :deploy_to, '/var/www/shame.nowinsky.net'
set :scm, :git

set :format, :pretty
# set :log_level, :debug
set :pty, true

# set :linked_files, %w{config/database.yml}
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
# set :keep_releases, 5

namespace :deploy do
  desc 'Install dependencies'
  task :install do
    on roles(:app), in: :sequence, wait: 5 do
      within "#{release_path}" do
        execute :npm, 'install'
      end
    end
  end

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
