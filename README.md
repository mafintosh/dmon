# dmon

Simple daemon control utility that aims to be cross-platform.
It is written in bash and available using [bashkit](https://github.com/mafintosh/bashkit)

	bashkit install git://github.com/mafintosh/dmon.git

## Usage

To create a new daemon simply run

	$ dmon create my-daemon-name file.sh

All daemons will be restarted when crashing and are launched when the system boots.
You can only create a daemon from an inline script

	$ dmon create my-daemon-name --script "node server.js"

After creating a daemon you need to start it

	$ dmon start my-daemon-name

Run `dmon --help` to get a list of all commands available

## OS Support

dmon has currently been tested and works on

* Ubuntu (using upstart)
* Mac OSX (using launchd)
