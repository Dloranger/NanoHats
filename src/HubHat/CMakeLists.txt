# Find the dl library - only for Linux, not required for FreeBSD
if (${CMAKE_SYSTEM_NAME} MATCHES "Linux")
  find_package(DL REQUIRED)
  set(LIBS ${LIBS} ${DL_LIBRARIES})
  include_directories(${DL_INCLUDES})
endif()

set(HUBHAT_SOURCE_DIR "${CMAKE_SOURCE_DIR}/HubHat" CACHE PATH

# Add targets for version files
set(VERSION_DEPENDS)

add_version_target(hubhat_ar VERSION_DEPENDS)
add_version_target(hubhat_aw VERSION_DEPENDS)
add_version_target(hubhat_dr VERSION_DEPENDS)
add_version_target(hubhat_dw VERSION_DEPENDS)

# Build the executable
add_executable(hubhat_ar bakebit_analog_read.c bakebit.c
  ${VERSION_DEPENDS}
)

add_executable(hubhat_aw bakebit_analog_write.c bakebit.c
  ${VERSION_DEPENDS}
)

add_executable(hubhat_dr bakebit_digital_read.c bakebit.c
  ${VERSION_DEPENDS}
)

add_executable(hubhat_dw bakebit_digital_write.c bakebit.c
  ${VERSION_DEPENDS}
)

# Install targets
install(TARGETS hubhat_ar DESTINATION ${BIN_INSTALL_DIR})
install(TARGETS hubhat_aw DESTINATION ${BIN_INSTALL_DIR})
install(TARGETS hubhat_dr DESTINATION ${BIN_INSTALL_DIR})
install(TARGETS hubhat_dw DESTINATION ${BIN_INSTALL_DIR})

