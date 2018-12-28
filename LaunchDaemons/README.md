# Installing
## To make these launch on boot

`$ sudo ln -s ~/.config/LaunchDaemons/<file> /Library/LaunchDaemons/<file>`
`$ sudo chmod 0644 <file>`
`$ sudo chown root:wheel <file>`

## To launch without rebooting:

$ sudo launchctl load -w /Library/LaunchDaemons/<file>

# To check sysctl/launchctl variables were set use launchctl

e.g. `launchctl limit maxfiles` for file `limit.maxfiles.plist`
See https://gist.github.com/abernix/a7619b07b687bb97ab573b0dc30928a0

