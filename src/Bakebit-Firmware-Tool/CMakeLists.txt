option(WITH_OLED_DAEMON "Set to ON to include HatOled Daemonizer support" OFF)
message(STATUS "With DEAMON = ${WITH_OLED_DAEMON}")
if(WITH_OLED_DAEMON)
  add_subdirectory(HatOled-Daemon)
endif(WITH_OLED_DAEMON)

option(WITH_OLED_SYSTEMD "Set to ON to include HatOled Systemd support" OFF)
message(STATUS "With Systemd = ${WITH_OLED_SYSTEMD}")
if(WITH_OLED_SYSTEMD)
  add_subdirectory(HatOled_Systemd)
endif(WITH_OLED_SYSTEMD)

set(FIRMWARE_TOOL_SOURCE_DIR "${CMAKE_SOURCE_DIR}/BakeBit-Firmware-Tool" CACHE PATH
	"Path to python files")
set(FIRMWARE_TOOL_INSTALL_DIR "${HAT_SHARE_INSTALL_DIR}/Firmware-Tool" CACHE PATH
	"Path to python script files")
	
# Install targets
install(FILES ${FIRMWARE_TOOL_SOURCE_DIR}/bakebit_firmare.hex firmware_update.sh 
		new_fw_earch.sh version.txt DESTINATION ${FIRMWARE_TOOL_INSTALL_DIR}
	)
