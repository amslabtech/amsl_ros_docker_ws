ROS_DISTRO ?= noetic
TARGET_WS  :=

install:
	@if [ -z "$(TARGET_WS)" ]; then echo "Please specify the target ROS workspace to install."; exit 1; fi
	mkdir -p $(TARGET_WS)/src
	mkdir -p $(TARGET_WS)/cache/$(ROS_DISTRO)/build
	mkdir -p $(TARGET_WS)/cache/$(ROS_DISTRO)/install
	mkdir -p $(TARGET_WS)/cache/$(ROS_DISTRO)/log
	cp -r $(ROS_DISTRO)/. $(TARGET_WS)/src/.devcontainer
