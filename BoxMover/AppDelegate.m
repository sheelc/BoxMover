//
//  AppDelegate.m
//  BoxMover
//
//  Created by Sheel Choksi on 7/19/14.
//  Copyright (c) 2014 Sheel Choksi. All rights reserved.
//

#import "AppDelegate.h"
#import "StatusItemController.h"
#import <IOKit/graphics/IOGraphicsLib.h>
#import "BoxMoverSettings.h"
#import "DisplaySetting.h"
#import "AppSetting.h"
#import "SizeSetting.h"

@interface AppDelegate ()

@property (strong, nonatomic) StatusItemController *statusItemController;
@property (strong, nonatomic) BoxMoverSettings *boxMoverSettings;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  self.boxMoverSettings = [self createBoxMoverSettings];
  self.statusItemController = [[StatusItemController alloc] initWithBoxMoverSettings:self.boxMoverSettings];
}

- (void)applicationWillTerminate:(NSNotification *)notification {
  [self saveBoxMoverSettings];
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

- (void)saveBoxMoverSettings {
  NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.boxMoverSettings];
  [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"boxMoverSettings"];
}

- (BoxMoverSettings *)createBoxMoverSettings {
  NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"boxMoverSettings"];
  BoxMoverSettings *boxMoverSettings;
  if (data) {
    boxMoverSettings = [NSKeyedUnarchiver unarchiveObjectWithData:data];
  } else {
    boxMoverSettings = [BoxMoverSettings new];
  }

  for (NSDictionary *displayDict in [self displays]) {
    BOOL foundDisplay = NO;
    for (DisplaySetting *dispSetting in boxMoverSettings.displaySettings) {
      if (dispSetting.productId == [displayDict[@"productId"] integerValue]) {
        foundDisplay = YES;
      }
    }

    if (!foundDisplay) {
      DisplaySetting *additionalDisplay = [DisplaySetting new];
      additionalDisplay.name = displayDict[@"name"];
      additionalDisplay.productId = [displayDict[@"productId"] integerValue];
      [boxMoverSettings.displaySettings addObject:additionalDisplay];
    }
  }

  return boxMoverSettings;
}

@end
