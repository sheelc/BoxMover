//
//  StatusItemController.h
//  BoxMover
//
//  Created by Sheel Choksi on 7/19/14.
//  Copyright (c) 2014 Sheel Choksi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BoxMoverSettings.h"
#import "BoxMover.h"

@protocol StatusItemControllerDelegate;

@interface StatusItemController : NSObject

@property (weak, nonatomic) id<StatusItemControllerDelegate> delegate;

- (id)initWithBoxMoverSettings:(BoxMoverSettings *)settings;

@end

@protocol StatusItemControllerDelegate

- (void)controllerWillOpenPreferences:(StatusItemController *)controller;
- (void)controllerDidClosePreferences:(StatusItemController *)controller;

@end
