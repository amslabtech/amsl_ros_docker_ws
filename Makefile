ROS_DISTRO ?= noetic
TARGET_WS  :=

install:
	@if [ -z "$(TARGET_WS)" ]; then echo "Please specify the target ROS workspace to install."; exit 1; fi
	mkdir -p $(TARGET_WS)/src
	mkdir -p $(TARGET_WS)/cache/build
	mkdir -p $(TARGET_WS)/cache/install
	mkdir -p $(TARGET_WS)/cache/log
	cp -r $(ROS_DISTRO) $(TARGET_WS)/src/.devcontainer
