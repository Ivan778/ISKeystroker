//
//  ISKeystrokeDynamicsRecognitionModulesHandler.h
//  KeyboardTest
//
//  Created by Иван on 4/23/19.
//  Copyright © 2019 Ivan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ISTextField.h"

typedef NS_ENUM(NSInteger, ISMode) {
    ISModeManhattan,
    ISModeManhattanFiltered,
    ISModeManhattanScaled,
    ISModeEnsemble
};

@interface ISKeystrokeDynamicsRecognitionModulesHandler : NSObject

- (instancetype)initWithTextField:(ISTextField*)textField;
- (NSNumber*)startProcessingWithDataAmount:(NSInteger)dataAmount andMode:(ISMode)mode;
- (void)resetData;

@end
