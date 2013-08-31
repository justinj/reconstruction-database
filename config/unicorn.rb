listen "127.0.0.1:8080"
worker_processes 2
user "rcdb"
working_directory "/home/rcdb/current"
pid "/home/unicorn/pids/unicorn.pid"
stderr_path "/home/unicorn/log/unicorn.log"
stdout_path "/home/unicorn/log/unicorn.log"
app_env "production"
