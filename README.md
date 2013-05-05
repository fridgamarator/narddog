# NardDog

### Run rails database backups from a web console

* Uses [Backup gem](https://github.com/meskyanichi/backup) to perform database backups to SFTP Storages and Rackspace Cloudfile Containers
* Currently only runs one-off backups to cloudfile containers

#### How-to

* install backup gem on remote server
* create an app
* create a cloudfile container
* create a backup
* click 'run backup'

#### TODO
* Varioius To-Do's throughout project `rake notes:todo`
* Recurring backups
* sftp backups
* other backup's (a3, dropbox, etc)
* file system backups
* fix layouts / css / styles (possibly convert to foundation)