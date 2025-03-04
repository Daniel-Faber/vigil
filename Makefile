# For local work: Define a variable to check if .env file exists
ENV_FILE := .env

# Check if the .env file exists, and include it if it does
ifneq ("$(wildcard $(ENV_FILE))","")
include $(ENV_FILE)
endif

# these will speed up builds, for docker-compose >= 1.25
export COMPOSE_DOCKER_CLI_BUILD=1
export DOCKER_BUILDKIT=1

# -----------------------------------

start:
	docker run -p 8080:8080 -v c://vigil/config.cfg:/etc/vigil.cfg valeriansaliou/vigil:v1.27.0

start-compose:
	docker compose up

build:
	docker build -f Dockerfile -t $(IMAGE_NAME) . \
	--build-arg SERVICE_NAME=$(SERVICE_NAME) \
	--build-arg UTILS_BASE_IMAGE_VERSION=$(UTILS_BASE_IMAGE_VERSION)