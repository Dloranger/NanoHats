set(PYTHON_SOURCE_DIR "${CMAKE_SOURCE_DIR}/software/HatOled-Python" CACHE PATH
	"Path to python files")
set(PYTHON_INSTALL_DIR "${BB_SHARE_INSTALL_DIR}/python" CACHE PATH
	"Path to python script files")
	
configure_file(${PYTHON_SOURCE_DIR}/bakebit.pth.in
	${PYTHON_SOURCE_DIR}/bakebit.pth)
message(STATUS "Python Path file:bakebit.pth")

# Where to install BakeBit install / setup script 
install(FILES ${PYTHON_SOURCE_DIR}/bakebit.pth
	DESTINATION ${CMAKE_INSTALL_FULL_LIBDIR}/python2.7/dist-packages
	)
message(STATUS "bakebit python path file will be installed to"
    "${SHARE_INSTALL_PREFIX}/python2.7/dist-packages/bakebit.pth after make install"
	)
# Install targets
install(FILES ${PYTHON_SOURCE_DIR}/DejaVuSansMono-Bold.ttf DejaVuSansMono.ttf bakebit.py 
	bakebit_128_64_oled.py bakebit_128_64_oled_animate.py bakebit_128_64_oled_image.py 
	bakebit_128_64_oled_shapes.py bakebit_128_64_oled_test.py bakebit_button.py 
	bakebit_buzzer.py  bakebit_led_blink.py bakebit_led_fade.py bakebit_ledbar.py 
	bakebit_light_sensor.py bakebit_nanohat_oled.py bakebit_prj_Button_And_Buzzer.py 
	bakebit_prj_LEDBar_And_RotaryAngleSensor.py bakebit_prj_Servo_And_RotaryAngleSensor.py 
	bakebit_prj_SmartLighting.py bakebit_prj_SystemInfo.py bakebit_prj_UIControl_via_Joystick.py
	bakebit_prj_Ultrasonic_Sensor_with_LED.py bakebit_servo.py bakebit_sound_sensor.py 
	bakebit_thumb_joystick.py bakebit_ultrasonic.py friendlyelec.png
	setup.py DESTINATION ${PYTHON_INSTALL_DIR}
	)
