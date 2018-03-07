# SST-Gradulator
An app for SST (School of Science and Technology, Singapore) for students to track their grades and set goals in order to encourage target setting and hitting those targets.

## Warning

This is a work in progress. Code might potentially be highly unstable and/or crash randomly.

### Installing (Please Ignore for Now)

Make sure you have pods installed. Run ``` $pod install ```

Create a new file, setup.swift. Paste the following into the file. This is to keep my personal keys safe sorry.

```
import Foundation

struct GlobalConstants {
    // Haven't setup keys in the file yet.
}
```

If you want to use these values in other areas of the app, simply call the global constant as such :

```
let string = GlobalConstants.string
print ("Your string: ", string)
```

You can test if it's working by placing this somewhere where it will run such as ViewDidLoad.
Please also import the google.info.plist, from firebase.

## Built With

* [Disk](https://github.com/saoudrizwan/Disk) - Data Persistence
* [SearchTextField](https://github.com/apasccon/SearchTextField) - Autocomplete Textfields
* [SCLAlertView](https://github.com/vikmeup/SCLAlertView-Swift) - Notifications and Popups


## Authors

* **Dalton Prescott** - *Main Developer* - [website](http://www.daltonprescott.com) | [github](https://github.com/dustarion)

## Acknowledgments
* Hat tip to anyone who's code was used
