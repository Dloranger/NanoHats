#############################################################################
# Nanopi OLED Hat Systemd setup
#############################################################################
set(SYSTEMD_CONFIGURATIONS_FILES_DIR "/lib/systemd/system" CACHE PATH
  "Path to systemd units")
set(SYSTEMD_SOURCE_DIR "${CMAKE_SOURCE_DIR}/OledHat/Oled_Systemd")

configure_file(${SYSTEMD_SOURCE_DIR}/oledhat.service.in
			${PROJECT_BINARY_DIR}/OledHat/Oled_Systemd/oledhat.service)
message(STATUS "Configured systemd unit file:nanohatoled.service")

install(FILES ${PROJECT_BINARY_DIR}/OledHat/Oled_Systemd/oledhat.service
    DESTINATION ${SYSTEMD_CONFIGURATIONS_FILES_DIR}
	)
message(STATUS "Systemd unit files will be installed to "
    "${SYSTEMD_CONFIGURATIONS_FILES_DIR} after make install"
	)
