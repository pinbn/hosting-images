[PHP]
engine = On
short_open_tag = On
asp_tags = Off
precision = 14
output_buffering = 4096
zlib.output_compression = Off
implicit_flush = Off
unserialize_callback_func =
serialize_precision = 17
disable_functions = pcntl_alarm,pcntl_fork,pcntl_waitpid,pcntl_wait,pcntl_wifexited,pcntl_wifstopped,pcntl_wifsignaled,pcntl_wexitstatus,pcntl_wtermsig,pcntl_wstopsig,pcntl_signal,pcntl_signal_dispatch,pcntl_get_last_error,pcntl_strerror,pcntl_sigprocmask,pcntl_sigwaitinfo,pcntl_sigtimedwait,pcntl_exec,pcntl_getpriority,pcntl_setpriority,proc_open,show_source,system,shell_exec,passthru,exec,popen
disable_classes =
zend.enable_gc = On
expose_php = Off
max_execution_time = 300
max_input_time = 60
memory_limit = <?= myenv("php_memory_limit", "20M") ?>
error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT & ~E_NOTICE
display_errors = Off
display_startup_errors = Off
date.timezone = America/Denver
log_errors = On
log_errors_max_len = 1024
open_basedir = /var/www/html/:/usr/share/fonts/:/tmp/
upload_tmp_dir = /tmp/
ignore_repeated_errors = Off
ignore_repeated_source = Off
report_memleaks = On
track_errors = Off
html_errors = On
error_log = syslog
variables_order = "GPCS"
request_order = "GP"
register_argc_argv = Off
auto_globals_jit = On
post_max_size = <?= myenv("php_upload_max_filesize"] ?? "20M") ?>
default_mimetype = "text/html"
enable_dl = Off
cgi.fix_pathinfo=1
file_uploads = On
upload_max_filesize = <?= myenv("php_upload_max_filesize"] ?? "20M") ?>
max_file_uploads = 20
allow_url_fopen = <?= myenv("php_allow_url_fopen"] ?? "Off") ?>
allow_url_include = Off
default_socket_timeout = 60
always_populate_raw_post_data=-1
geoip.custom_directory =

[opcache]
opcache.enable=1
opcache.memory_consumption=1024
opcache.interned_strings_buffer=8
opcache.max_accelerated_files=16000
opcache.revalidate_freq=30
opcache.fast_shutdown=1
opcache.enable_cli=1

[CLI Server]
cli_server.color = On

[mail function]
SMTP = <?= myenv("php_smtp_server", "localhost") ?>
smtp_port = <?= myenv("php_smtp_port"] ?? "25") ?>
mail.add_x_header = On
mail.log = /var/log/php.mail.log

[SQL]
sql.safe_mode = Off

[PostgreSQL]
pgsql.allow_persistent = On
pgsql.auto_reset_persistent = Off
pgsql.max_persistent = -1
pgsql.max_links = -1
pgsql.ignore_notice = 0
pgsql.log_notice = 0

[Session]
session.save_handler = files
session.save_path = "/tmp"
session.use_strict_mode = 0
session.use_cookies = 1
session.use_only_cookies = 1
session.name = PHPSESSID
session.auto_start = 0
session.cookie_lifetime = 0
session.cookie_path = /
session.cookie_domain =
session.cookie_httponly =
session.serialize_handler = php
session.gc_probability = 0
session.gc_divisor = 1000
session.gc_maxlifetime = 1440
session.bug_compat_42 = Off
session.bug_compat_warn = Off
session.referer_check =
session.cache_limiter = nocache
session.cache_expire = 180
session.use_trans_sid = 0
session.hash_function = 0
session.hash_bits_per_character = 5
url_rewriter.tags = "a=href,area=href,frame=src,input=src,form=fakeentry"

