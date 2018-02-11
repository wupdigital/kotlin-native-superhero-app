# Marvel Superhero App for iOS

[![Build Status](https://travis-ci.org/wupdigital/ios-superhero-app.svg?branch=master)](https://travis-ci.org/wupdigital/ios-superhero-app)

## Description

The application is made using [Marvel API](https://developer.marvel.com), for explain the use of Clean Architecture and MVP in Objective-C.

## Run Requirements

* Xcode 9.2

## Build and run the application

To run the application using real data obtained from the [Marvel API](https://developer.marvel.com) create a `marvel.pch` file inside the project directory and add your public and private key there as follows:

```
#define MARVEL_PUBLIC_API_KEY     YOUR_PUBLIC_API_KEY
#define MARVEL_PRIVATE_API_KEY    YOUR_PRIVATE_API_KEY
```