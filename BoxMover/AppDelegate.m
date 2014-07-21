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

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  self.statusItemController = [[StatusItemController alloc] initWithBoxMoverSettings:[self createBoxMoverSettings]];
}

- (NSMutableArray *)displays {
  NSMutableArray *displayInfos = [NSMutableArray new];
  for (NSScreen *screen in [NSScreen screens]) {
    CGDirectDisplayID displayID = (CGDirectDisplayID)[[screen deviceDescription][@"NSScreenNumber"] integerValue];
    NSDictionary *displayInfo = CFBridgingRelease(IODisplayCreateInfoDictionary(CGDisplayIOServicePort(displayID), 0));
    NSString *productIDKey = [NSString stringWithCString:kDisplayProductID encoding:NSUTF8StringEncoding];
    NSString *nameKey = [NSString stringWithCString:kDisplayProductName encoding:NSUTF8StringEncoding];

    [displayInfos addObject:@{@"productID":displayInfo[productIDKey], @"name":displayInfo[nameKey][@"id"]}];
  }

    return displayInfos;
}

- (NSDictionary *)plist {
  return @{@61509: @[
               @{@"name": @"Google Chrome", @"sizes": @[@{@"x": @10, @"y": @44, @"w":@34, @"h":@49},
                                                        @{@"x": @11, @"y": @44, @"w":@34, @"h":@50}]},
               @{@"name":@"Firefox", @"sizes": @[]}
               ],
           };
}

- (BoxMoverSettings *)createBoxMoverSettings {
  NSMutableArray *displaySettings = [NSMutableArray new];
  for (NSDictionary *displayInfo in [self displays]) {
    NSArray *apps = [self plist][displayInfo[@"productID"]];
    NSMutableArray *appSettings = [NSMutableArray new];

    for (NSDictionary *appDict in apps) {
      NSMutableArray *sizeSettings = [NSMutableArray new];

      for (NSDictionary *size in appDict[@"sizes"]) {
        SizeSetting *sizeSetting = [SizeSetting new];
        sizeSetting.coordinates = [NSMutableDictionary dictionaryWithDictionary:size];
        [sizeSettings addObject:sizeSetting];
      }

      AppSetting *appSetting = [AppSetting new];
      appSetting.name = appDict[@"name"];
      appSetting.sizeSettings = sizeSettings;
      [appSettings addObject:appSetting];
    }

    DisplaySetting *displaySetting = [DisplaySetting new];
    displaySetting.appSettings = appSettings;
    displaySetting.name = displayInfo[@"name"];
    [displaySettings addObject:displaySetting];
  }

  BoxMoverSettings *settings = [BoxMoverSettings new];
  settings.displaySettings = displaySettings;
  return settings;
}


@end
