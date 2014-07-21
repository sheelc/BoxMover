//
//  BoxSettingsManager.h
//  BoxMover
//
//  Created by Sheel Choksi on 7/20/14.
//  Copyright (c) 2014 Sheel Choksi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BoxMoverSettings.h"

@interface BoxSettingsManager : NSObject

- (BoxMoverSettings *)createBoxMoverSettings;
- (void)saveBoxMoverSettings;

@end
