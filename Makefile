DEBUG = 0
TARGET = iphone:latest
PACKAGE_VERSION = 1.1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = KBSwipe9
KBSwipe9_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk