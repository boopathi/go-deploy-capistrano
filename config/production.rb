servers = IO.read("production.serverlist").split
role(:app) { servers }


