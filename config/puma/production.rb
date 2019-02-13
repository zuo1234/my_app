#!/usr/bin/env puma

directory '/data/my_app/current'
port        ENV.fetch("PORT") { 8001 }
rackup "/data/my_app/current/config.ru"
environment 'production'

bind 'unix:///data/my_app/shared/tmp/sockets/puma.sock'
pidfile "/data/my_app/shared/tmp/pids/puma.pid"
state_path "/data/my_app/shared/tmp/pids/puma.state"
stdout_redirect '/data/my_app/shared/log/puma_access.log', '/data/my_app/shared/log/puma_error.log', true


daemonize true
workers 4
threads 4,32

preload_app!
plugin :tmp_restart