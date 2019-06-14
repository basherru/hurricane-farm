namespace :hurricane do
  task :setup do
    Rake::Task["db:drop"].invoke
    Rake::Task["db:create"].invoke
    Rake::Task["db:migrate"].invoke
    teams_host_format = ENV.fetch('TEAMS_HOST_FORMAT')
    teams_range       = eval ENV.fetch('TEAMS_RANGE')
    teams_range.each do |id|
      host = teams_host_format.sub('#', id.to_s)
      Team.create(title: "Team-#{id}", host: host, status: 1)
    end
  end
end