#!/bin/bash

BOARD_NAME=teensy32
BUILD_DIR="build-${BOARD_NAME}"
rm -rf ${BUILD_DIR}; mkdir ${BUILD_DIR}; cd ${BUILD_DIR}; cmake -DBOARD_NAME=${BOARD_NAME} ../
