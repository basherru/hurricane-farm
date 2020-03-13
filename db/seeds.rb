# frozen_string_literal: true

def create_exploits!(count: 5)
  count.times do |i|
    Exploit.find_or_create_by(source: "puts \"123\"", title: "Exploit_#{i.next}")
  end
end

def create_teams!(count: 30)
  count.times do |i|
    Team.find_or_create_by!(host: "192.168.#{i.next}.1", title: "Team_#{i.next}")
  end
end

def create_flags!(count: 5000)
  count.times do
    Flag.find_or_create_by!(
      team: Team.all.sample,
      exploit: Exploit.all.sample,
      content: SecureRandom.base58(31).upcase + "=",
      pts: rand * 100,
      created_at: rand(8.hour).seconds.ago,
    )
  end
end

create_teams!
create_exploits!
create_flags!
