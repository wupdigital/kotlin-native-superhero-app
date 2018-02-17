#!/bin/sh

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# ACTIONS
# These are implemented as functions, and just called by the
# short MAIN section below

buildAction () {
    echo "Building..."

    case "$PLATFORM_NAME" in
        iphoneos)
            TARGET=iphone
            TASK=compileKonanCommonIphone
            ;;
        iphonesimulator)
            TARGET=iphone_sim
            TASK=compileKonanCommonIphone_sim
            ;;
        *)
            echo "Unknown platform: $PLATFORM_NAME"
            exit 1
            ;;
    esac

    if [ -d "$SRCROOT/../common/build/konan" ]; then
        rm -rf "$SRCROOT/../common/build/konan"
    fi

    mkdir -p "$SRCROOT/../common/build/konan/bin/"
    ln -s "$TARGET" "$SRCROOT/../common/build/konan/bin/xcode"

    if [ "$CONFIGURATION" == "Debug" ]; then
        ENABLE_DEBUG=true
    else
        ENABLE_DEBUG=false
    fi

    "$SRCROOT/../gradlew" -p "$SRCROOT/../" ":common:$TASK" -PenableDebug=$ENABLE_DEBUG
}

cleanAction () {
    "$SRCROOT/../gradlew" -p "$SRCROOT/../" ":common:clean"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# MAIN

echo "Running with ACTION=${ACTION}"

case "$ACTION" in
    clean)
        cleanAction
        ;;
    *)
        buildAction
        ;;
esac
exit 0
