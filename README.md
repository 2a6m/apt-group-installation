# apt-group-installation
It's a script bash to automatisate the installation of package group

## Installation
Download the zip project

```bash
unzip apt-group-installation.zip
rm apt-group-installation.zip
cd apt-group-installation
```
or git project

```bash
git clone https://github.com/2a6m/apt-group-installation.git
cd apt-group-installation
```

And execute `run.sh`
```bash
./run.sh
```

## Use
Configure each of your package group by editing files in list directory to have **Your** custom installation

* each line must contain the name of **1** package
* The script doesn't read commented lines
* The script will generate a group with all the packages (the group all)
