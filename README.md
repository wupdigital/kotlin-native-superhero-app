# Marvel Superhero App for iOS

[![Build Status](https://travis-ci.org/wupdigital/ios-swift-superhero-app.svg?branch=master)](https://travis-ci.org/wupdigital/ios-swift-superhero-app)

## Description

The application is made using [Marvel API](https://developer.marvel.com), for explain the use of Clean Architecture and MVP in Swift.

## Run Requirements

* Xcode 9.2

## Build and run the application

To run the application using real data obtained from the [Marvel API](https://developer.marvel.com) create a `env-vars.sh` file inside the project directory and add your public and private key there as follows:

```
export MARVEL_PUBLIC_API_KEY=YOUR_PUBLIC_API_KEY
export MARVEL_PRIVATE_API_KEY=YOUR_PRIVATE_API_KEY
```

Before compile Swift files, Sourcery will generate a configuration file with these credentials
