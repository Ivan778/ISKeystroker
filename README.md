# ISKeystrokeDynamics

ISKeystrokeDynamics is a framework for user identifying using keystroke dynamics recognition.

Keystroke is unique for every user, so, we may analyse how users types his password, for example.

A keystroke dynamics recognition method is convenient for users and security departures due to the fact that keystroke dynamics monitoring is made in a hidden mode and does not requires any extra actions from users.

## Why

Why should you use ISKeystrokeDynamics?

- easy to use
- additional security for your app
- provides 4 different methods of calculating user score

## Requirements

iOS 9.0 or any higher version

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate ISKeystrokeDynamics into your Xcode project using CocoaPods, specify the following in your `Podfile`:

```ruby
pod 'ISKeystrokeDynamics'
```

Then, run the following command:

```bash
$ pod install
```

### Manually

1. Simply drag ISKeystrokeDynamics.framework to your project:

![image](https://github.com/Ivan778/ISKeystroker/blob/master/images/step_1.png)

2. Select "Copy items if needed", "Create folder references" and press finish:

![image](https://github.com/Ivan778/ISKeystroker/blob/master/images/step_2.png)

3. Go to GENERAL tab, select YOUR_PROJECT target and press "Add items":

![image](https://github.com/Ivan778/ISKeystroker/blob/master/images/step_3.png)

4. Select ISKeystrokeDynamics.framework and press finish:

![image](https://github.com/Ivan778/ISKeystroker/blob/master/images/step_4.png)

## How it works

ISKeystrokeDynamics framework has two phases: 

- learning phase
- identifying phase

In the learning phase framework collects information about how user types the password (such metrics as holdTime, downDownTime, upDownTime). If the needed amount of information was collected, framework starts identifying the user (identifying phase). Needed amount of information is just number of password repetitions. Developer sets number of password repetitions (it must be at least 10).

## Usage

Set your main.m file as following:

```Objective-C
#import <UIKit/UIKit.h>
#import <ISKeystrokeDynamics/ISKeystrokeDynamics.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, NSStringFromClass([ISApplication class]), NSStringFromClass([AppDelegate class]));
    }
}
```

ISApplication is used for detecting down events on the keyboard, so, for the right work of the framework you need to set main.m as written above.

```Objective-C
#import "ViewController.h"
#import <ISKeystrokeDynamics/ISKeystrokeDynamics.h>

@interface ViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet ISTextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@property (nonatomic, strong) ISKeystrokeDynamicsRecognitionModulesHandler *kdrmh;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _textField.delegate = self;
    _kdrmh = [[ISKeystrokeDynamicsRecognitionModulesHandler alloc] initWithTextField:_textField];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self userDidEnterPassword];
    return YES;
}

- (void)userDidEnterPassword {
    [_textField resignFirstResponder];
    // Check password first!!!!!!!!!!
    if ([_textField.text isEqualToString:@"UsersPassword"]) {
        NSNumber *result = [_kdrmh startProcessingWithDataAmount:12 andMode:ISModeManhattanFiltered];
        if (result != nil) {
            if (fabs([result doubleValue]) <= 65) {
                [_resultLabel setText:@"Real user!"];
            } else if (fabs([result doubleValue]) > 65) {
                [_resultLabel setText:@"Fake user!"];
            }
        }
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Wrong password!" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        _textField.text = [NSString string];
    }
}
```

`ISKeystrokeDynamicsRecognitionModulesHandler` object is using for handling of the framework. First you should initialize it and pass as parameter textfield of type `ISTextField` (textfield for password entering). When user entered password, first you need to check, if it's correct, and only after it call the method below:

```Objective-C
[_kdrmh startProcessingWithDataAmount:12 andMode:ISModeManhattanFiltered];

```

`amount` is number of password repetitions. `mode` is used for selecting of how typing result will be calculated. You may use one of the following modes:

- ISModeManhattan
- ISModeManhattanFiltered
- ISModeManhattanScaled
- ISModeEnsemble

`ISModeEnsemble` is combination if the first three. About other modes you may read [here](https://www.cs.cmu.edu/~maxion/pubs/KillourhyMaxion09.pdf).
If framework is still in learning phase, the return value of `startProcessingWithDataAmount:andMode:` will be `nil`. If framework is in identifying phase, `startProcessingWithDataAmount:andMode:` method will return `NSNumber`, which contains user score. If the absolute value of the user score less than 65, password was typed by real user. 

If user changed password, framework should learn, how user enters new password. To reset information about the previous password just call `resetData` method.

## Example projet

The example project demonstrates how it's easy to use ISKeystrokeDynamics. Have a look! 😎

## Authors

* **Ivan Suprynovich** 
- i.suprynovich@gmail.com
- [VK-page](https://vk.com/ivanushka7798)

## License

This project is licensed under the Apache 2.0 License - see the [LICENSE](LICENSE) file for details
