//
//  PreferencesController.m
//  BoxMover
//
//  Created by Sheel Choksi on 7/19/14.
//  Copyright (c) 2014 Sheel Choksi. All rights reserved.
//

#import "PreferencesController.h"

@implementation PreferencesController

- (id)initWithDisplays:(NSMutableArray *)displays {
  self = [super initWithWindowNibName:NSStringFromClass([self class]) owner:self];
  if (self) {
    self.displays = [self mergePlistWithActiveDisplays:displays];
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

- (NSMutableArray *)mergePlistWithActiveDisplays:(NSMutableArray *)displays {
  NSMutableArray *merged = [NSMutableArray new];
  for (NSDictionary *displayInfo in displays) {
    NSMutableDictionary *displayDictionaryWithApps = [NSMutableDictionary dictionaryWithDictionary:displayInfo];
    NSArray *apps = [self plist][displayInfo[@"productID"]];
    if (apps) {
      NSMutableArray *mutableApps = [NSMutableArray new];
      for (NSDictionary *appDict in apps) {
        NSMutableDictionary *mutableAppDict = [NSMutableDictionary dictionaryWithDictionary:appDict];
        NSMutableArray *mutableSizes = [NSMutableArray new];
        for (NSDictionary *size in appDict[@"sizes"]) {
          [mutableSizes addObject:[NSMutableDictionary dictionaryWithDictionary:size]];
        }

        mutableAppDict[@"sizes"] = mutableSizes;
        [mutableApps addObject:mutableAppDict];
      }

      displayDictionaryWithApps[@"apps"] = mutableApps;
    } else {
      displayDictionaryWithApps[@"apps"] = [NSMutableArray new];
    }

    [merged addObject:displayDictionaryWithApps];
  }

  return merged;
}

@end
