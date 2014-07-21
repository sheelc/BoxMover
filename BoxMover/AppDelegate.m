//
//  AppDelegate.m
//  BoxMover
//
//  Created by Sheel Choksi on 7/19/14.
//  Copyright (c) 2014 Sheel Choksi. All rights reserved.
//

#import "AppDelegate.h"
#import "StatusItemController.h"
#import "BoxSettingsManager.h"
#import "BoxMoverSettings.h"
#import "BoxMover.h"

@interface AppDelegate ()

@property (strong, nonatomic) StatusItemController *statusItemController;
@property (strong, nonatomic) BoxSettingsManager *boxSettingsManager;
@property (strong, nonatomic) BoxMover *boxMover;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  self.boxSettingsManager = [BoxSettingsManager new];
  BoxMoverSettings *settings = [self.boxSettingsManager createBoxMoverSettings];
  self.statusItemController = [[StatusItemController alloc] initWithBoxMoverSettings:settings];
  self.boxMover = [[BoxMover alloc] initWithBoxMoverSettings:settings];
  [self.boxMover registerEvents];
}

- (void)applicationWillTerminate:(NSNotification *)notification {
  [self.boxSettingsManager saveBoxMoverSettings];
}

@end
