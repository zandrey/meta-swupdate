#
# Version Collector class for SWUpdate component
#
# This class should be inherited by components, which are later included in SWU
# file and required to be versioned there (via sw-description's 'version' parameter).
#
# This class would produce a file in deployment folder with the name of the
# component and would list a pair:
# <name of component>     <version>
#
# Files produced by multiple components would later be combined into sw-versions
# file, which is used to udpate <pkg-ver></pkg-ver> tags in sw-description file
# and could also be taken directly into the target rootfs and verified by swupdate
# in runtime.
#

do_generate_package_ver_for_swu() {
        # Create folder where version file should be present
        install -d ${DEPLOY_DIR_IMAGE}/swupdate-versions

	# If the SRCREV is set - use it to report the version, otherwise report PV
	if [ "${SRCREV}" != "AUTOINC" ] && [ "${SRCREV}" != "INVALID" ]; then
		echo "${BPN}    ${SRCREV}" > ${DEPLOY_DIR_IMAGE}/swupdate-versions/${BPN}.version
	else
		bbnote "Recipe does not provide valid SRCREV, use PV as reported version"
		echo "${BPN}    ${PV}" > ${DEPLOY_DIR_IMAGE}/swupdate-versions/${BPN}.version
	fi
}

addtask generate_package_ver_for_swu before do_build after do_compile
