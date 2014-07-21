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

@end

@implementation BoxSettingsManager

- (BoxMoverSettings *)createBoxMoverSettings {
  NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"boxMoverSettings"];
  if (data) {
    self.boxMoverSettings = [NSKeyedUnarchiver unarchiveObjectWithData:data];
  } else {
    self.boxMoverSettings = [BoxMoverSettings new];
  }

  for (NSDictionary *displayDict in [self displays]) {
    BOOL foundDisplay = NO;
    for (DisplaySetting *dispSetting in self.boxMoverSettings.displaySettings) {
      if (dispSetting.productId == [displayDict[@"productId"] integerValue]) {
        foundDisplay = YES;
      }
    }

    if (!foundDisplay) {
      DisplaySetting *additionalDisplay = [DisplaySetting new];
      additionalDisplay.name = displayDict[@"name"];
      additionalDisplay.productId = [displayDict[@"productId"] integerValue];
      [self.boxMoverSettings.displaySettings addObject:additionalDisplay];
    }
  }

  return self.boxMoverSettings;
}

- (void)saveBoxMoverSettings {
  NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.boxMoverSettings];
  [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"boxMoverSettings"];
}

- (NSArray *)displays {
  NSMutableArray *displayInfos = [NSMutableArray new];
  for (NSScreen *screen in [NSScreen screens]) {
    CGDirectDisplayID displayID = (CGDirectDisplayID)[[screen deviceDescription][@"NSScreenNumber"] integerValue];
    NSDictionary *displayInfo = CFBridgingRelease(IODisplayCreateInfoDictionary(CGDisplayIOServicePort(displayID), 0));
    NSString *productIDKey = [NSString stringWithCString:kDisplayProductID encoding:NSUTF8StringEncoding];
    NSString *nameKey = [NSString stringWithCString:kDisplayProductName encoding:NSUTF8StringEncoding];

    [displayInfos addObject:@{@"productId":displayInfo[productIDKey], @"name":displayInfo[nameKey][@"id"]}];
  }

  return displayInfos;
}

@end
