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

set(PYTHON_SOURCE_DIR "${CMAKE_SOURCE_DIR}/HatOled-Python" CACHE PATH
	"Path to python files")
set(PYTHON_INSTALL_DIR "${HAT_SHARE_INSTALL_DIR}/python" CACHE PATH
	"Path to python script files")
	
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
