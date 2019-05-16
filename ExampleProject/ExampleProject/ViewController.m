//
//  ViewController.m
//  ExampleProject
//
//  Created by Иван on 5/16/19.
//  Copyright © 2019 Ivan. All rights reserved.
//

#import "ViewController.h"
#import <ISKeystrokeDynamics/ISKeystrokeDynamics.h>

@interface ViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet ISTextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;

@property (nonatomic, strong) ISKeystrokeDynamicsRecognitionModulesHandler *kdrmh;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _textField.delegate = self;
    _kdrmh = [[ISKeystrokeDynamicsRecognitionModulesHandler alloc] initWithTextField:_textField];
    _resetButton.layer.masksToBounds = YES;
    _resetButton.layer.cornerRadius = 20;
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
- (IBAction)resetFramewrokPressed:(id)sender {
    [_kdrmh resetData];
}

@end
