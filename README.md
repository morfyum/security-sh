# Installation

Install on `Fedora`, `CentOS`, and `RedHat` from copr repo:

```sh
sudo dnf copr enable morfyum/security-sh
```

You can Download the latest `security-sh.sh` script from `000-ready-to-build/` and copy to `/usr/local/bin/`

```sh
wget https://github.com/morfyum/security-sh/blob/main/000-ready-to-build/security-sh-0.1.0/security-sh.sh

sudo cp ./security-sh.sh /usr/local/bin/
sudo chmod 755 /usr/local/bin/security-sh.sh
```

Use `security-sh`:
```sh
security-sh.sh
```


# Build RPM package 

## [ 1 ] Install required packages

```sh
sudo dnf install -y rpmdevtools rpmlint
```

## [ 2 ] Build library
rpmbuilds is created under non-root user home folder: ~/

```sh
cd ~/ && rpmdev-setuptree && cd ./rpmbuilds
```

### Result:
```sh
.
├── BUILD
├── RPMS
├── SOURCES
├── SPECS
└── SRPMS
```

The [ BUILD ] directory is used during the build process of the RPM package. This is where the temporary files are stored, moved around, etc.

The [ RPMS ] directory holds RPM packages built for different architectures and noarch if specified in .spec file or during the build.

The [ SOURCES ] directory, as the name implies, holds sources. This can be a simple script, a complex C project that needs to be compiled, a pre-compiled program, etc. Usually, the sources are compressed as .tar.gz or .tgz files.

The [ SPEC ] directory contains the .spec files. The .spec file defines how a package is built. More on that later.

The [ SRPMS ] directory holds the .src.rpm packages. A Source RPM package doesn't belong to an architecture or distribution. The actual .rpm package build is based on the .src.rpm package.


## [ 3 ] Build your project folder with version
for example:  my-program-0.0.1

```sh
# create a folder
mkdir -p ./ready-to-build/my-project-0.0.1

put your files into this folder
cp ~/my_app/* ./ready-to-build/my-project-0.0.1/
```


## Create an archive file from your project

```sh
# cd to directory where is your project file!
cd ./ready-to-build/
tar --create --file my-program-0.0.1.tar.gz ./my-program-0.0.1
cd ..
```


### Move the tarball you've just created into the SOURCES/ directory:

```sh
mv ./ready-to-build/my-program-0.0.1.tar.gz ./SOURCES/
```


## [ 4 ] Create a .spec file

```sh
rpmdev-newspec ./SPECS/my-program.spec
```

### Edit .spec file by your prefeferences


## [ 5 ] BUILD YOUR RPM PACKAGE BY .spec FILE

```sh
# Create .src rpm package
rpmbuild -bs ./SPECS/my-program.spec
 
# Create binary .rpm package 
rpmbuild -bb ./SPECS/my-program.spec
```

