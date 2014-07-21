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

@interface AppDelegate ()

@property (strong, nonatomic) StatusItemController *statusItemController;
@property (strong, nonatomic) BoxSettingsManager *boxSettingsManager;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  self.boxSettingsManager = [BoxSettingsManager new];
  self.statusItemController = [[StatusItemController alloc] initWithBoxMoverSettings:[self.boxSettingsManager createBoxMoverSettings]];
}

- (void)applicationWillTerminate:(NSNotification *)notification {
  [self.boxSettingsManager saveBoxMoverSettings];
}

@end
