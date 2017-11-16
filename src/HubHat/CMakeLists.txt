# Find the dl library - only for Linux, not required for FreeBSD
if (${CMAKE_SYSTEM_NAME} MATCHES "Linux")
  find_package(DL REQUIRED)
  set(LIBS ${LIBS} ${DL_LIBRARIES})
  include_directories(${DL_INCLUDES})
endif()

# Add targets for version files
set(VERSION_DEPENDS)

add_version_target(bb_ar VERSION_DEPENDS)
add_version_target(bb_aw VERSION_DEPENDS)
add_version_target(bb_dr VERSION_DEPENDS)
add_version_target(bb_dw VERSION_DEPENDS)

# Build the executable
add_executable(bb_ar bakebit_analog_read.c bakebit.c
  ${VERSION_DEPENDS}
)

add_executable(bb_aw bakebit_analog_write.c bakebit.c
  ${VERSION_DEPENDS}
)

add_executable(bb_dr bakebit_digital_read.c bakebit.c
  ${VERSION_DEPENDS}
)

add_executable(bb_dw bakebit_digital_write.c bakebit.c
  ${VERSION_DEPENDS}
)

# Install targets
install(TARGETS bb_ar DESTINATION ${SBIN_INSTALL_DIR})
install(TARGETS bb_aw DESTINATION ${SBIN_INSTALL_DIR})
install(TARGETS bb_dr DESTINATION ${SBIN_INSTALL_DIR})
install(TARGETS bb_dw DESTINATION ${SBIN_INSTALL_DIR})

