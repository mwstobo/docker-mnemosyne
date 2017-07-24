# docker-mnemosyne
Dockerfile for Mnemosyne

## Building
There are six build arguments: `mnemosyne_buildhost`, `mnemosyne_version`, `mnemosyne_tar_filename`, `matplotlib_buildhost`, `matplotlib_version`, `matplotlib_tar_filename`. Use these to to customize where mnemosyne and matplotlib sources are downloaded from. Note you should only need to touch the version arguments.

## Usage
* Run the basic application
```shell
$ docker run -d -p 8512:8512 -p 8513:8513 mnemosyne
```

* Run the application with persistent data
```shell
$ DATA_DIR=/path/to/data/dir
$ docker run -d \
             -v $DATA_DIR:/opt/mnemosyne/data \
             -p 8512:8512 -p 8513:8513 \
             mnemosyne
```
