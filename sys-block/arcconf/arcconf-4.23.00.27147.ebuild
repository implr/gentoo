# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PV="B$(ver_cut 4)"

inherit linux-info

DESCRIPTION="Microsemi Adaptec RAID Controller Command Line Utility"
HOMEPAGE="https://www.microsemi.com/"
SRC_URI="http://download.adaptec.com/raid/storage_manager/${PN}_${MY_PV}.zip"
S="${WORKDIR}"

LICENSE="Microsemi"
SLOT="0"
KEYWORDS="-* amd64 arm64"

BDEPEND="app-arch/unzip"

RESTRICT="mirror bindist"

QA_PREBUILT="usr/bin/arcconf"

pkg_setup() {
	# CONFIG_HARDENED_USERCOPY_PAGESPAN makes ARCCONF segault
	if linux-info_get_any_version && linux_config_src_exists; then
		CONFIG_CHECK="!HARDENED_USERCOPY_PAGESPAN"
		check_extra_config
	fi
}

src_install() {
	dobin linux$(usex arm64 'arm' '')_x64/cmdline/arcconf
}
