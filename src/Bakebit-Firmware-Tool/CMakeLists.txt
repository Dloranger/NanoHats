option(WITH_ARDUINO_SOURCE "Set to ON to include Arduino Source Code" OFF)
message(STATUS "With Systemd = ${WITH_ARDUINO_SOURCE}")
if(WITH_ARDUINO_SOURCE)
  add_subdirectory(Arduino_Source)
endif(WITH_ARDUINO_SOURCE)



install(FILES ${PROJECT_BINARY_DIR}/systemd/nanohatoled.service
        DESTINATION ${SYSTEMD_CONFIGURATIONS_FILES_DIR})
message(STATUS "Systemd unit files will be installed to "
        "${SYSTEMD_CONFIGURATIONS_FILES_DIR} after make install")

install(FILES ${PROJECT_BINARY_DIR}/systemd/nanohatoled
        DESTINATION ${SYSTEMD_DEFAULTS_FILES_DIR} )
message(STATUS "Systemd unit configuration files will be "
               "installed to ${SYSTEMD_DEFAULTS_FILES_DIR} "
               "after make install")
