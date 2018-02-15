# Marvel Superhero App for Android and iOS

[![Build Status](https://travis-ci.org/wupdigital/kotlin-native-superhero-app.svg?branch=master)](https://travis-ci.org/wupdigital/kotlin-native-superhero-app)

## Description

The Android and iOS applications are made using [Marvel API](https://developer.marvel.com), for explain the use of Clean Architecture and MVP in Swift/Kotlin/Kotlin Native

## Run Requirements

* Xcode 9.2
* Android SDK

## Build and run the application

To run the application using real data obtained from the [Marvel API](https://developer.marvel.com) create a `env-vars.sh` file inside the project directory and add your public and private key there as follows:

```
export MARVEL_PUBLIC_API_KEY=YOUR_PUBLIC_API_KEY
export MARVEL_PRIVATE_API_KEY=YOUR_PRIVATE_API_KEY
```

Before compile Swift files, Sourcery will generate a configuration file with these credentials
