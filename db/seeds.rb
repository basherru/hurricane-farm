5.times do |i|
  Exploit.find_or_create_by(source: "puts \"123\"", title: "Exploit_#{i.next}")
end
30.times do |i|
  team = Team.find_or_create_by(host: "192.168.#{i.next}.1", title: "Team_#{i.next}")
  rand(500).times do
    content = SecureRandom.base58(31).upcase + "="
    Flag.find_or_create_by!(content: content, team: team, exploit: Exploit.all.sample, pts: rand * 30, created_at: rand(8.hours).seconds.ago)
  end
end