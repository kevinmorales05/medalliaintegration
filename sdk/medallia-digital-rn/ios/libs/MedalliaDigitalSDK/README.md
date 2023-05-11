![alt text](https://image.ibb.co/bCPDQw/Medallia_color_logo.png)

## Medallia Digital iOS SDK

[![Platform](https://img.shields.io/badge/MedalliaDigitalSDK-pass-green.svg)](https://github.medallia.com/Digital/MobileSDK-Distribution-iOS)
[![Cocoapods Compatible](https://img.shields.io/badge/CocoaPods-compatible-brightgreen.svg?style=flat)](https://github.medallia.com/Digital/MobileSDK-Distribution-iOS/MedalliaDigital.framework)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)


## Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Communication](#communication)
- [Credits](#credits)
- [License](#license)

## Requirements

- iOS 8.0+
- Swift 3.0+

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate MedalliaDigitalSDK into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target '<Your Target Name>' do
pod 'MedalliaDigitalSDK', '~> 2.4.0'
end
```

Then, run the following command:

```bash
$ pod install
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate MedalliaDigitalSDK into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "MedalliaDigitalSDK/MedalliaDigitalSDK" ~> 2.4.0
```

Run `carthage update` to build the framework and drag the built `MedalliaDigitalSDK.framework` into your Xcode project.

### Manually

If you prefer not to use either of the aforementioned dependency managers, you can integrate MedalliaDigitalSDK into your project manually.

---

## Usage

### Quick Start

```swift
import MedalliaDigitalSDK

class MyViewController: UIViewController {

override func viewDidLoad() {
super.viewDidLoad()

MedalliaDigital.sdkInit(token: "secretToken", success: {
print("Init finished successfuly")
}) { (error) in
print("Error: \(error)")
}
}
}
```



## Communication

- If you **need help**, use [Medallia Digital](http://www.medallia.com/solutions/digital/).
- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.

### Resources

- [Documentation](http://www.medallia.com/solutions/digital/)
- [F.A.Q.](http://www.medallia.com/solutions/digital/)

## Credits

- Medallia Digital

## License

MedalliaDigitalSDK is released under the Apache license. See LICENSE for details.

