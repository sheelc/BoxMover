//
//  BoxMover.h
//  BoxMover
//
//  Created by Sheel Choksi on 7/20/14.
//  Copyright (c) 2014 Sheel Choksi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BoxMoverSettings.h"
#import "DisplayManager.h"

@interface BoxMover : NSObject

- (id)initWithBoxMoverSettings:(BoxMoverSettings *)settings displayManager:(DisplayManager *)displayManager;
- (void)removeEvents;
- (void)registerEvents;

@end
