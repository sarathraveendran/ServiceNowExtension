# ServiceNowExtension

[![Version](https://img.shields.io/cocoapods/v/ServiceNowExtension.svg?style=flat)](https://cocoapods.org/pods/ServiceNowExtension)
[![License](https://img.shields.io/cocoapods/l/ServiceNowExtension.svg?style=flat)](https://cocoapods.org/pods/ServiceNowExtension)
[![Platform](https://img.shields.io/cocoapods/p/ServiceNowExtension.svg?style=flat)](https://cocoapods.org/pods/ServiceNowExtension)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

iOS 10.0+ / macOS 10.12+ / tvOS 10.0+ / watchOS 3.0+
Xcode 10.1+
Swift 4.2+

## Usage

 Import ServiceNowExtension in your view controller
 then Initiate SNManager Instance with required details.
 
       domain   =  "Servicenow domain url"
       userName =  "Service now account userid"
       password =  "Service now password"
       var snManager = SNManager(domain, userName: userName, password: password)

       
 Once the instance created you can raise your ticket through createIncidentTicket() method and pass the required parameters
   
    func createATicket() {
        
        let subject = "Subject 1"
        let priority = "High"
        let description = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book"
        let incidentImage = #imageLiteral(resourceName: "picx")
     
        snManager.createIncidentTicket(subject, priority: priority, description: description, image: incidentImage) { (status, message) in
            
            print(status)
        }
    }


## Installation

ServiceNowExtension is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ServiceNowExtension'
```

## Usage Description

Import ServiceNowExtension in your view controller then Initiate SNManager Instance with required details.

```
domain   =  "Servicenow domain url"
userName =  "Service now account userid"
password =  "Service now password"
var snManager = SNManager(domain, userName: userName, password: password)
Once the instance created you can raise your ticket through createIncidentTicket() method and pass the required parameters

func createATicket() {

let subject = "Subject 1"
let priority = "High"
let description = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book"
let incidentImage = #imageLiteral(resourceName: "picx")

snManager.createIncidentTicket(subject, priority: priority, description: description, image: incidentImage) { (status, message) in

print(status)
}
}
```

## Author

Sarath Raveendran

## License

ServiceNowExtension is available under the MIT license. See the LICENSE file for more info.
