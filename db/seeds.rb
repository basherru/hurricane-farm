team    = Team.find_or_create_by(host: '0.0.0.0', title: 'test')
exploit = Exploit.find_or_create_by(source: 'test')
Flag.find_or_create_by!(content: 'test', team: team, exploit: exploit)