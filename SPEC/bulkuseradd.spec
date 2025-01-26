Name:           bulkuseradd
Version:        1.0.0
Release:        1%{?dist}
Summary:        A bulk user creation tool for Linux systems

License:        MIT
URL:            https://github.com/yourusername/bulkuseradd
Source0:        bulkuseradd-1.0.0.tar.gz

Requires:       bash
BuildArch:      noarch

%description
bulkuseradd is a command-line utility to add multiple users to Linux systems in bulk. It supports user creation from files or command-line arguments, assigning groups, setting default shells, passwords, and UID ranges.

%prep
%setup -q

%install
mkdir -p %{buildroot}/usr/local/bin
mkdir -p %{buildroot}/usr/share/man/man8

# Install the bulkuseradd script
install -m 0755 bulkuseradd %{buildroot}/usr/local/bin/

# Install the man page
install -m 0644 bulkuseradd.8 %{buildroot}/usr/share/man/man8/

%files
/usr/local/bin/bulkuseradd
/usr/share/man/man8/bulkuseradd.8

%changelog
* Sun Jan 26 2025 Gaurav Sidharth Bharane <your.email@example.com> - 1.0.0-1
- Initial release of bulkuseradd
