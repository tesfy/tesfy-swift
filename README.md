<p align="center">
  <img alt="logo" src="https://tesfy.s3.us-west-2.amazonaws.com/images/logo.png" width="220">
</p>

<p align="center">
  A lightweight A/B Testing and Feature Flag Swift library focused on performance ⚡️
</p>

<div align="center">
    <a href="https://travis-ci.org/gringox/Tesfy">    
        <image alt="CI status" src="https://img.shields.io/travis/gringox/Tesfy.svg?style=flat">    
    </a>
    <a href="https://cocoapods.org/pods/Tesfy">    
        <image alt="Version" src="https://img.shields.io/cocoapods/v/Tesfy.svg?style=flat">    
    </a>
    <a href="https://cocoapods.org/pods/Tesfy">    
        <image alt="License" src="https://img.shields.io/cocoapods/l/Tesfy.svg?style=flat">    
    </a>
    <a href="https://cocoapods.org/pods/Tesfy">    
        <image alt="CI status" src="https://img.shields.io/cocoapods/p/Tesfy.svg?style=flat">    
    </a>
  <a href="https://discord.gg/QxEcWYc">    
    <image alt="discord chat" src="https://img.shields.io/discord/704771560782692474?label=&logo=discord&logoColor=ffffff&color=7389D8&labelColor=6A7EC2">    
  </a>
</div>

## Usage

### Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

### Installation

Tesfy is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Tesfy'
```

### Initialization
Import and instantiate it with a datafile. A datafile is a `json` that defines the experiments and features avaliable. Ideally this file should be hosted somewhere outside your application (for example in [S3](https://aws.amazon.com/s3/)), so it could be fetched during boostrap or every certain time. This will allow you to make changes to the file without deploying the application.

```swift
import Tesfy

let datafile = """
    {
        "experiments": {
            "experiment-1": {
                "id": "experiment-1",
                "percentage": 90,
                "variations": [{
                    "id": "0",
                    "percentage": 50
                }, {
                    "id": "1",
                    "percentage": 50
                }]
            },
            "experiment-2": {
                "id": "experiment-2",
                "percentage": 100,
                "variations": [{
                    "id": "0",
                    "percentage": 100
                }],
                "audience": {
                    "==": [{ "var": "countryCode" }, "us"]
                }
            }
        },
        "features": {
            "feature-1": {
                "id": "feature-1",
                "percentage": 50
            }
        }
    }
"""

let tesfy = Tesfy(datafile: datafile)
```

### Experiments
Check which variation of an experiment is assigned to a user.

```swift
let userId = '676380e0-7793-44d6-9189-eb5868e17a86'
let experimentId = 'experiment-1'

tesfy.getVariationId(experimentId: experimentId, userId: userId) // "1"
```

### Feature Flags
Check if a feature is enabled for a user.

```swift
let userId = '676380e0-7793-44d6-9189-eb5868e17a86'
let featureId = 'feature-1'

tesfy.isFeatureEnabled(featureId: featureId, userId: userId) // true
```

### Audiences
Use attributes to target an specific audience.

```swift
let userId = '676380e0-7793-44d6-9189-eb5868e17a86'
let experimentId = 'experiment-2'

tesfy.getVariationId(experimentId: experimentId, userId: userId, attributes: "{ \"countryCode\": \"ve\" }") // nil
tesfy.getVariationId(experimentId: experimentId, userId: userId, attributes: "{ \"countryCode\": \"us\" }") // "0"
```

## Integrations

Tesfy is also available in different frameworks or libraries to provide a better API to use alongside those.
- [react-tesfy](https://github.com/andresz1/react-tesfy)

## Feedback

Pull requests, feature ideas and bug reports are very welcome. We highly appreciate any feedback.

## Author

[Pedro Valdivieso (gringox)](https://pedrovaldivieso.com/)

## License

Tesfy is available under the MIT license. See the LICENSE file for more info.
