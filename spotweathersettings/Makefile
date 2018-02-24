include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = spotweathersettings
spotweathersettings_FILES = SWSRootListController.m
spotweathersettings_INSTALL_PATH = /Library/PreferenceBundles
spotweathersettings_FRAMEWORKS = UIKit
spotweathersettings_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/spotweathersettings.plist$(ECHO_END)
