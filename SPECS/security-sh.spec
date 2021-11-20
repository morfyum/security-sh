# HOW TO BUILD RPM PACKAGE
# https://www.redhat.com/sysadmin/create-rpm-package
# https://docs.fedoraproject.org/en-US/packaging-guidelines/RPMMacros/
#
Name:           security-sh
Version:        0.1.0
Release:        1%{?dist}
Summary:        Command line interface for ClamAV
BuildArch:      noarch

License:        GPL
URL:            github.com/morfyum
Source0:        %{name}-%{version}.tar.gz

#BuildRequires:  
Requires:       bash, clamav


%description
RPM build for security.sh bash script. Security.sh is a lightweight Command Line interface for ClamAV antivirus software.


%prep
%setup -q

%install

mkdir -p $RPM_BUILD_ROOT/%{_bindir}
mkdir -p $RPM_BUILD_ROOT/%{_docdir}/%{name}
install -p -m 755 %{name}.sh $RPM_BUILD_ROOT/%{_bindir}

%clean
rm -rf $RPM_BUILD_ROOT

%files
%{_bindir}/%{name}.sh
#%%doc README.md

%changelog
* Sat Nov 20 2021 Márton Józsa <morfyum@gmail.com>
- First security.sh build
