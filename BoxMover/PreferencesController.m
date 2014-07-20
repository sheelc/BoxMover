//
//  PreferencesController.m
//  BoxMover
//
//  Created by Sheel Choksi on 7/19/14.
//  Copyright (c) 2014 Sheel Choksi. All rights reserved.
//

#import "PreferencesController.h"
#import "BoxMoverSettings.h"
#import "DisplaySetting.h"
#import "AppSetting.h"
#import "SizeSetting.h"

@interface PreferencesController ()

@property (strong, nonatomic) BoxMoverSettings *boxMoverSettings;

@end

@implementation PreferencesController

- (id)initWithDisplays:(NSMutableArray *)displays {
  self = [super initWithWindowNibName:NSStringFromClass([self class]) owner:self];
  if (self) {
    self.boxMoverSettings = [self mergePlistWithActiveDisplays:displays];
  }
  return self;
}

- (NSDictionary *)plist {
  return @{@61509: @[
               @{@"name": @"Google Chrome", @"sizes": @[@{@"x": @10, @"y": @44, @"w":@34, @"h":@49},
                                                        @{@"x": @11, @"y": @44, @"w":@34, @"h":@50}]},
               @{@"name":@"Firefox", @"sizes": @[]}
               ],
          };
}

- (BoxMoverSettings *)mergePlistWithActiveDisplays:(NSMutableArray *)displays {
  NSMutableArray *displaySettings = [NSMutableArray new];
  for (NSDictionary *displayInfo in displays) {
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
