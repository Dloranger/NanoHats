set(PYTHON_SOURCE_DIR "${CMAKE_SOURCE_DIR}/HatOled-Python" CACHE PATH
	"Path to python files")
set(PYTHON_INSTALL_DIR "${HAT_SHARE_INSTALL_DIR}/python" CACHE PATH
	"Path to python script files")
	
# Install targets
install(FILES ${PYTHON_SOURCE_DIR}/  DESTINATION ${PYTHON_INSTALL_DIR}
	)

add_subdirectory(hatmotor)
add_subdirectory(examples)