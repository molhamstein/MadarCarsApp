# Jawlatcom

A cross platform mobile application using Dart with The Flutter framework.

## Prerequisites

* Basic knowledge of *Dart* and *Dart 2*
* Familiar with *Flutter*
* Basic understanding of mobile app development 
* Familiar with Android *Material design* and IOS *Cupertino*
* Comfortable with Reactive programming.
* Comfortable with the **BLOC** pattern.

## Getting Started 😍

**Jawlatcom** is a trip booking app around Turkey.

This project uses:
- [x] Flutter 1.2
- [x] Dart 2

### Running the project 

>`git clone https://github.com/molhamstein/MadarCarsApp.git`

After cloning the project use `flutter packages get`
to update your dependencies.

Then simply run it on a device or a simulator with `flutter run`.

## Structure 💩

The project uses the **BLOC** pattern.

#### Backend
* All API calls are in the *Network.dart* class.
* Store and retrieve User, access token and other data from *DataStore.dart* class. 
* Every Widget **COULD** have a bloc, and every action **SHOULD** have a controller. *-Ayham Orfali* 😜

#### Frontend 
* Use `setState()` only in small widgets or actions.

## Known Issues ☔

#### flutter.h not found on IOS builds

1. Run $ flutter doctor and make sure everything is okay.
2. Update Cocoa-pods and Flutter SDK and make sure you’re on the master branch
3. Go to root flutter sdk
 
   > flutter -> bin -> cache -> artifacts -> engine -> ios-release 
	
    you’ll notice *Flutter.framework* and *Flutter.framework.zip*
    
	Go to 
	
	> Flutter.framework -> Headers
	
	If the files are shortcuts:
	1. Go back and unzip Flutter.framework.zip
	2. Replace it’s content with the old *Flutter.framework*
    3. Delete the unzipped file but keep *Flutter.framework.zip*
		
4. Delete your *podfile.lock* in your projects IOS file
5. Refer to [this comment](https://github.com/flutter/flutter/issues/16049#issuecomment-382629492) and add the corresponding lines in your pod file
6. In your project run 

    >`$ pod install`
 ## internal change

 change compile version of flutter_pdf_renderer to 28