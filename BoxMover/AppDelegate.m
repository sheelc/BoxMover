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
#import "DisplayManager.h"

@interface AppDelegate ()<StatusItemControllerDelegate>

@property (strong, nonatomic) StatusItemController *statusItemController;
@property (strong, nonatomic) BoxSettingsManager *boxSettingsManager;
@property (strong, nonatomic) DisplayManager *displayManager;
@property (strong, nonatomic) BoxMover *boxMover;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  self.displayManager = [DisplayManager new];
  self.boxSettingsManager = [[BoxSettingsManager alloc] initWithDisplayManager:self.displayManager];
  BoxMoverSettings *settings = [self.boxSettingsManager createBoxMoverSettings];

  self.boxMover = [[BoxMover alloc] initWithBoxMoverSettings:settings displayManager:self.displayManager];

  self.statusItemController = [[StatusItemController alloc] initWithBoxMoverSettings:settings];
  self.statusItemController.delegate = self;
  [self.boxMover registerEvents];
}

- (void)applicationWillTerminate:(NSNotification *)notification {
  [self.boxSettingsManager saveBoxMoverSettings];
}

- (void)controllerWillOpenPreferences:(StatusItemController *)controller {
  [self.boxMover removeEvents];
}

- (void)controllerDidClosePreferences:(StatusItemController *)controller {
  [self.boxMover registerEvents];
}

@end
