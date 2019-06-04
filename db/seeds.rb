30.times do |i|
  Team.find_or_create_by(host: "192.168.#{i.next}.1", title: "Team_#{i.next}")
  Exploit.find_or_create_by(source: "puts \"123\"", title: "Exploit_#{i.next / 5}")
end
1500.times do
  content = SecureRandom.base58(31).upcase + "="
  Flag.find_or_create_by!(content: content, team: Team.all.sample, exploit: Exploit.all.sample, pts: rand * 30, created_at: rand(1.hour).seconds.ago)
end