#!/bin/zsh
set -eo

# Xcode
rm -rf ~/Library/Developer/Xcode/DerivedData

# Simulator
sudo killall -9 com.apple.CoreSimulator.CoreSimulatorService
rm -rf ~/Library/Developer/CoreSimulator
xcrun simctl erase all
