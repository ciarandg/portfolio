---
title: "Sideloading on a Peloton"
date: 2025-11-01T00:00:00-06:00
draft: false
tags: ["fitness", "android"]
downloads: []
blog: true
tableOfContents: false
---

{{< wrapimg src="yowamushi.jpg" alt="Yowamushi Pedal playing on a Pelaton bike" caption="Watch your weeaboo cycling content while you pedal!" align="right" >}}

I own a first-generation Peloton bike (long story), and have never felt willing to pay the $34.99 CAD monthly fee to access their content and workouts. For years, this has effectively turned the bike a very large paperweight. For the uninitiated, without a paid subscription you are limited to the "just ride" mode, which is the equivalent of cycling while staring at an odometer.

However, today I learned that it is trivial to sideload whatever applications you'd like onto the bike. Additionally, there's [homebrew software](https://github.com/selalipop/grupetto) available to display an overlay with your stats overtop of whatever app you have open. Unfortunately this information is scattered across junky fitness websites and Reddit threads, so I'm consolidating the steps here.

## Installing a Custom Launcher

If you're familiar with Android development, you'll be pleased to learn that Peloton have made no effort to prevent you from using `adb` on their tablets via USB debugging. These steps assume that you already have `adb` installed and are using a Linux laptop, though they should be trivial to adapt for commercial operating systems.

1. On the Peloton's tablet, navigate to `Settings > Device Settings > System > About tablet`, and tap the `Build number` field at the bottom 7 times. You should see a prompt informing you that you are "now a developer".
2. Back out to the `System` menu and open `Developer options`, then enable the `USB debugging` toggle.
3. On your laptop, run `adb start-server` to start the daemon.
   - Note: In the past I've run into device recognition issues caused by missing udev rules, which you can usually work around by running adb as root via `sudo`.
4. On your laptop, run `adb devices`. You should see no connected devices.
5. Connect the tablet to your laptop. You should see a prompt to allow USB debugging on your machine. Hit `ALLOW` on this prompt.
6. On your laptop, run `adb devices`. You should now see a connected device.
7. At this point you can install whatever APKs you like on the tablet by running `adb install <PATH_TO_APK>`. My preferred launcher is Lawnchair, so I downloaded the APK from their [downloads page](https://lawnchair.app/downloads/) and installed that.
8. Once you have installed your preferred launcher, tap the Peloton logo at the bottom of the screen. This is the tablet's home button, so you'll be prompted to choose which launcher to navigate to the home screen with. Select your newly installed launcher.
9. Repeat the process in steps 7-8 for any other apps you'd like to sideload via `adb`.

## Recommendations

1. As with any Android device, I'd suggest using a proper package manager if possible. The only two apps I installed through `adb` on my tablet were [Lawnchair](https://lawnchair.app/) and [Droid-ify](https://github.com/Droid-ify/client), my preferred FDroid client. From there, I used Droid-ify to install [Obtanium](https://github.com/ImranR98/Obtainium) for managing apps that aren't available in the FDroid repositories.
2. The apps I have currently installed via FDroid: Obtanium, Jellyfin
3. The apps I have currently installed via Obtanium: [Cromite](https://github.com/uazo/cromite), [grupetto](https://github.com/selalipop/grupetto)
4. When installing Cromite via Obtanium, pick `arm64_ChromePublic`.

## grupetto

grupetto is a wonderful little Android app that provides an overlay with your current stats (power, cadence, resistance, speed) on top of whatever other app you are using. For me, this is a game-changer. Unfortunately there is no support for more complex features like session tracking, as it is [considered out-of-scope](https://github.com/selalipop/grupetto?tab=readme-ov-file#unimplemented-features) by the maintainer. If I find myself using this setup consistently, I'll likely either contribute some features upstream or fork the app and build it into a more complete workout suite. I miss writing Kotlin, so it'd be a good excuse :)
