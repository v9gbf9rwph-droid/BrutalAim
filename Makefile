ARCHS = arm64 arm64e
TARGET = iphone:clang:latest:14.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = BrutalAim

BrutalAim_FILES = Tweak.xm
BrutalAim_CFLAGS = -fobjc-arc
BrutalAim_FRAMEWORKS = Foundation UIKit

include $(THEOS_MAKE_PATH)/tweak.mk
