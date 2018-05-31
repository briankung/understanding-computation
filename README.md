## Testing

Currently using [`entr`] and this simple shell script to rerun tests:

`$ while sleep 1 ; do find . -name '*.rb' | entr -s 'rake test' ; done`

Notifications are handled with [`terminal-notifier`].

[`entr`]: https://superuser.com/a/665208
[`terminal-notifier`]: https://github.com/julienXX/terminal-notifier
