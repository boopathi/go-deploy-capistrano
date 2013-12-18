servers = IO.read("staging.serverlist").split

role(:app) { servers }
