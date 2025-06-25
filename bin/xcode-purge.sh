#!/bin/sh
set -e

echo "Remove derived data"
rm -rf ~/Library/Developer/Xcode/DerivedData

echo "Reset packages cache"
rm -rf ~/Library/Caches/org.swift.swiftpm/repositories
rm -rf ~/Library/Caches/com.apple.dt.\*
rm -rf ~/Library/org.swift.swiftpm

echo "Simulator cleanup"
xcrun simctl shutdown all && xcrun simctl erase all
