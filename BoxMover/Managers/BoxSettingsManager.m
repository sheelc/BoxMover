//
//  BoxSettingsManager.m
//  BoxMover
//
//  Created by Sheel Choksi on 7/20/14.
//  Copyright (c) 2014 Sheel Choksi. All rights reserved.
//

#import "BoxSettingsManager.h"
#import "DisplaySetting.h"

@interface BoxSettingsManager ()

@property (strong, nonatomic) BoxMoverSettings *boxMoverSettings;
@property (strong, nonatomic) DisplayManager *displayManager;

@end

@implementation BoxSettingsManager

- (id)initWithDisplayManager:(DisplayManager *)displayManager {
  self = [super init];
  if (self) {
    self.displayManager = displayManager;
  }

  return self;
}

- (BoxMoverSettings *)createBoxMoverSettings {
  NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"boxMoverSettings"];
  if (data) {
    self.boxMoverSettings = [NSKeyedUnarchiver unarchiveObjectWithData:data];
  } else {
    self.boxMoverSettings = [BoxMoverSettings new];
  }

  for (DisplayInfo *dispInfo in [self.displayManager displays]) {
    BOOL foundDisplay = NO;
    for (DisplaySetting *dispSetting in self.boxMoverSettings.displaySettings) {
      if (dispSetting.productId == dispInfo.productId) {
        foundDisplay = YES;
      }
    }

    if (!foundDisplay) {
      DisplaySetting *additionalDisplay = [DisplaySetting new];
      additionalDisplay.displayInfo = dispInfo;
      [self.boxMoverSettings.displaySettings addObject:additionalDisplay];
    }
  }

  return self.boxMoverSettings;
}

- (void)saveBoxMoverSettings {
  NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.boxMoverSettings];
  [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"boxMoverSettings"];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
