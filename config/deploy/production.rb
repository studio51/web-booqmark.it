set :branch, "develop"

server '54.77.55.35',
  user: 'ubuntu',
  roles: %w{web app},
  ssh_options: {
    user: 'ubuntu',
    forward_agent: true,
    keys: %w('/Users/vladsmarteditors/.ssh/booqmark.it.pem'),
    auth_methods: %w(publickey password),
    password: 'please use keys'
  }
