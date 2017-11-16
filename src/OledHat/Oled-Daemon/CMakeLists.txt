set(DAEMON_SOURCE_DIR "${CMAKE_SOURCE_DIR}/OledHat/Oled-Daemoon" CACHE PATH
	"Path to python files")
set(CMAKE_C_FLAGS "-lrt -lpthread")
# Add targets for version files
set(VERSION_DEPENDS)

configure_file(${DAEMON_SOURCE_DIR}/bakebit.pth.in
	${DAEMON_SOURCE_DIR}/bakebit.pth)
message(STATUS "Python Path file:bakebit.pth")

add_version_target(nanohatoled VERSION_DEPENDS)

# Build the executable
add_executable(nanohatoled daemonize.c main.c
  ${VERSION_DEPENDS}
)

# Where to install BakeBit install / setup script 
install(FILES ${DAEMON_SOURCE_DIR}/OledHat/Oled_Daemon/bakebit.pth
	DESTINATION ${CMAKE_INSTALL_FULL_LIBDIR}/python2.7/dist-packages
	)
message(STATUS "bakebit python path file will be installed to"
    "${SHARE_INSTALL_PREFIX}/python2.7/dist-packages/bakebit.pth after make install"
	)
# Install targets
install(TARGETS nanohatoled DESTINATION ${BIN_INSTALL_DIR})
