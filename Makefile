export ARCHS = armv7 arm64
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = spotweather
spotweather_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += spotweathersettings
include $(THEOS_MAKE_PATH)/aggregate.mk
