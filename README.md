# Dokku

This is a modified version of [Dokku](https://github.com/progrium/dokku) used by
[Dokku Installer](https://dokku.net).

## Dokku Installer

[Dokku Installer](https://dokku.net) is a web based interface for spinning up servers
with this version of Dokku already installed. Most of the additional tools included
with the install are specific to Rails apps.

## Dokku Installer CLI

[Dokku Installer CLI](https://github.com/brianpattison/dokku-installer-cli) is the
command line tool that only works with this version of Dokku and simplifies the
commands available on your local machine.

```
$ dokku help

Commands:
  dokku config                                    # Display the app's environment variables
  dokku config:get KEY                            # Display an environment variable value
  dokku config:set KEY1=VALUE1 [KEY2=VALUE2 ...]  # Set one or more environment variables
  dokku config:unset KEY1 [KEY2 ...]              # Unset one or more environment variables
  dokku domains                                   # Display the app's domains
  dokku domains:set DOMAIN1 [DOMAIN2 ...]         # Set one or more domains
  dokku help [COMMAND]                            # Describe available commands or one specific command
  dokku logs [-t]                                 # Show the last logs for the application (-t follows)
  dokku open                                      # Open the application in your default browser
  dokku postgres:backups                          # List available PostgreSQL backups
  dokku postgres:backups:create                   # Create a new PostgreSQL backup
  dokku postgres:backups:disable                  # Disable daily PostgreSQL backups
  dokku postgres:backups:download <number>        # Download the numbered PostgreSQL backup
  dokku postgres:backups:enable                   # Enable daily PostgreSQL backups
  dokku postgres:backups:restore:local <number>   # Restore the numbered PostgreSQL backup locally
  dokku restart                                   # Restart the application
  dokku run <cmd>                                 # Run a command in the environment of the application
  dokku ssh                                       # Start an SSH session as root user
  dokku ssl:add CRT KEY                           # Add an SSL endpoint.
  dokku ssl:force DOMAIN                          # Force SSL on the given domain.
  dokku ssl:remove                                # Remove an SSL endpoint.
  dokku update                                    # Update dokku-installer-cli to latest version
  dokku upgrade                                   # Upgrade the Dokku install on your remote server
  dokku url                                       # Show the URL for the application
  dokku version                                   # Show version information
```
