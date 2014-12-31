set :branch, 'develop'

server '54.194.238.70',
  user: 'ubuntu',
  roles: %w{web app},
  ssh_options: {
    user: 'ubuntu',
    forward_agent: true,
    auth_methods: %w(publickey password),
    password: 'please use keys'
  }
