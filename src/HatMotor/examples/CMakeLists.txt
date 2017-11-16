set(PYTHON_SOURCE_DIR "${CMAKE_SOURCE_DIR}/HatOled-Python" CACHE PATH
	"Path to python files")
set(PYTHON_INSTALL_DIR "${HAT_SHARE_INSTALL_DIR}/hatmotor" CACHE PATH
	"Path to python script files")
	
# Install targets
install(FILES ${PYTHON_SOURCE_DIR}/_init_.py ez_setup.py FriendlyElec_I2C.py FriendlyElec_NanoHatMotor.py 
		FriendlyELEC_PWM_Servo_Driver.py setup.py DESTINATION ${PYTHON_INSTALL_DIR}
	)

add_subdirectory(examples)