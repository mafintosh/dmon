# dmon

Simple daemon control utility that aims to be cross-platform.
It is written in bash and build using [bashkit](https://github.com/mafintosh/bashkit)

One-line install

	 curl -fs https://raw.github.com/mafintosh/dmon/master/install | bash && . $(bashkit rc)

## Usage

To create a new daemon simply run

	$ dmon create my-daemon-name file.sh

All daemons are configured to be restarted when crashing and launched when the system boots.
You can also create a daemon from an command using `--command` or `-c`

	$ dmon create my-daemon-name --command "node server.js"

If you don't want the daemon to launch when the system boots use `--no-boot` or `-n`

	$ dmon create my-daemon-name --no-boot --command "node server.js"

After creating a daemon you need to start it

	$ dmon start my-daemon-name

You can also pass `--start` to `dmon create` to start it right away.
To stop the daemon use

	$ dmon stop my-daemon-name

Run `dmon --help` to get a list of all commands available or use autocompletion `dmon <tab><tab>`.
`dmon create --<tab><tab>` will list available options to create.

## OS Support

dmon has currently been tested and works on

* Ubuntu (using upstart)
* Mac OSX (using launchd)
* Debian/Raspberri (using init.d)

When using init.d dmon uses a small deamon to respawn processes when they crash.
If anyone know of a better solution respawn using init.d please let me know.