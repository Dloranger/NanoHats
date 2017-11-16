set(CMAKE_C_FLAGS "-lrt -lpthread")

# Add targets for version files
set(VERSION_DEPENDS)

add_version_target(nanohatoled VERSION_DEPENDS)

# Build the executable
add_executable(nanohatoled daemonize.c main.c
  ${VERSION_DEPENDS}
)

# Install targets
install(TARGETS nanohatoled DESTINATION ${BIN_INSTALL_DIR})
