set(OLEDHAT_SOURCE_DIR "${CMAKE_SOURCE_DIR}/MotorHat" CACHE PATH
	"Path to python files")
set(OLEDHAT_INSTALL_DIR "${HAT_SHARE_INSTALL_DIR}/motorhat" CACHE PATH
	"Path to python script files")
	
# Install targets
install(FILES ${MOTORHAT_SOURCE_DIR}/__init__.py ez_setup.py FriendlyELEC_I2C.py 
		FriendlyELEC_NanoHatMotor.py FriendlyELEC_PWM_Servo_Driver.py 
		README.md setup.py DESTINATION ${MOTORHAT_INSTALL_DIR}
	)
