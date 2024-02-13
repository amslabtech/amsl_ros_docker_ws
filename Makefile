ROS_DISTRO ?= noetic
TARGET_WS  :=
NVIDIA_DOCKER ?= false
DOCKER_COMPOSE_FILE := docker-compose.yml

ifeq ($(NVIDIA_DOCKER), true)
	DOCKER_COMPOSE_FILE := docker-compose.nvidia.yml
endif

install:
	@if [ -z "$(TARGET_WS)" ]; then echo "Please specify the target ROS workspace to install."; exit 1; fi
	mkdir -p $(TARGET_WS)/src
	mkdir -p $(TARGET_WS)/cache/$(ROS_DISTRO)/build
	mkdir -p $(TARGET_WS)/cache/$(ROS_DISTRO)/install
	mkdir -p $(TARGET_WS)/cache/$(ROS_DISTRO)/log
	cp -r $(ROS_DISTRO)/devcontainer.json $(TARGET_WS)/src/.devcontainer/devcontainer.json
	cp -r $(ROS_DISTRO)/Dockerfile $(TARGET_WS)/src/.devcontainer/Dockerfile
	cp -r $(ROS_DISTRO)/$(DOCKER_COMPOSE_FILE) $(TARGET_WS)/src/.devcontainer/docker-compose.yml
