THEOS_DEVICE_IP = localhost
THEOS_DEVICE_PORT = 2222
ARCHS = arm64
include /home/artikus/theos/makefiles/common.mk

TWEAK_NAME = CydiaXI
CydiaXI_FILES = Tweak.xm
CydiaXI_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 Cydia"
