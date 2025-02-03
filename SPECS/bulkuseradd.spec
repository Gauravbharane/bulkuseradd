Name:           bulkuseradd
Version:        1.0
Release:        1%{?dist}
Summary:        A professional script for bulk user creation and management
License:        GPLv3
URL:            https://github.com/gauravbharane
Source0:        bulkuseradd.sh
Source1:        bulkuseradd.8
BuildArch:      noarch
Requires:       bash, coreutils, shadow-utils

%description
bulkuseradd is a powerful command-line tool designed for system administrators to efficiently create multiple 
user accounts in bulk. It supports user provisioning from files or direct input, automatic UID allocation, 
group assignments, password enforcement, logging, and custom shell configurations.

Features:
- Bulk user creation via command line or file input.
- Automatic and manual UID assignment.
- Customizable default shell and group assignment.
- Secure password configuration with optional expiration policies.
- Logging support for tracking user creation.

Developed by Gaurav Sidharth Bharane <gauravb1839@gmail.com>.
Source code and contributions: https://github.com/gauravbharane

%prep
# No special preparation required

%build
# No compilation required

%install
# Install the script
mkdir -p %{buildroot}/usr/local/bin
install -m 755 %{SOURCE0} %{buildroot}/usr/local/bin/bulkuseradd

# Install the man page
mkdir -p %{buildroot}/usr/share/man/man8
install -m 644 %{SOURCE1} %{buildroot}/usr/share/man/man8/bulkuseradd.8

%files
/usr/local/bin/bulkuseradd
/usr/share/man/man8/bulkuseradd.8*

%changelog
* Mon Feb 3 2025 Gaurav Sidharth Bharane <gauravb1839@gmail.com> - 1.0-1
- Initial release of bulkuseradd with full support for batch user creation and logging.

