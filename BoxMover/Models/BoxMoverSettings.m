//
//  BoxMoverSettings.m
//  BoxMover
//
//  Created by Sheel Choksi on 7/20/14.
//  Copyright (c) 2014 Sheel Choksi. All rights reserved.
//

#import "BoxMoverSettings.h"
#import "AppSetting.h"
#import "SizeSetting.h"
#import "DefaultAppSetting.h"

@implementation BoxMoverSettings

- (id)init {
  self = [super init];
  if (self) {
    self.displaySettings = [NSMutableArray new];
    self.otherMonitorCombo = [NSMutableDictionary new];
  }

  return self;
}

- (NSArray *)allHotKeyDictionaries {
  NSMutableSet *hotKeys = [NSMutableSet new];
  for (DisplaySetting *dispSetting in self.displaySettings) {
    for (AppSetting *appSetting in dispSetting.appSettings) {
      for (SizeSetting *sizeSetting in appSetting.sizeSettings) {
        [hotKeys addObject:sizeSetting.srKeyCombo];
      }
    }
  }

  if (self.otherMonitorCombo) {
    [hotKeys addObject:self.otherMonitorCombo];
  }

  return [hotKeys allObjects];
}

- (CGRect)rectForKeyCombo:(NSDictionary *)keyCombo app:(NSString *)appName displayInfo:(DisplayInfo *)displayInfo {
  DisplaySetting *foundDisplaySetting;
  for (DisplaySetting *dispSetting in self.displaySettings) {
    if (dispSetting.productId == displayInfo.productId) {
      foundDisplaySetting = dispSetting;
      break;
    }
  }

  AppSetting *foundAppSetting;
  for (AppSetting *appSetting in foundDisplaySetting.appSettings) {
    if ([appSetting.name isEqualToString:appName]) {
      foundAppSetting = appSetting;
      break;
    }
  }

  AppSetting *defaultAppSetting;
  for (AppSetting *appSetting in foundDisplaySetting.appSettings) {
    if ([appSetting isKindOfClass:[DefaultAppSetting class]]) {
      defaultAppSetting = appSetting;
    };
  }

  SizeSetting *foundSizeSetting;
  for (SizeSetting *sizeSetting in foundAppSetting.sizeSettings) {
    if ([sizeSetting.srKeyCombo isEqual:keyCombo]) {
      foundSizeSetting = sizeSetting;
      break;
    }
  }

  if (!foundSizeSetting) {
    for (SizeSetting *sizeSetting in defaultAppSetting.sizeSettings) {
      if ([sizeSetting.srKeyCombo isEqual:keyCombo]) {
        foundSizeSetting = sizeSetting;
        break;
      }
    }
  }

  CGRect rect = CGRectMake([foundSizeSetting.coordinates[@"x"] floatValue],
                           [foundSizeSetting.coordinates[@"y"] floatValue],
                           [foundSizeSetting.coordinates[@"w"] floatValue],
                           [foundSizeSetting.coordinates[@"h"] floatValue]);
  return rect;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
  self.displaySettings = [aDecoder decodeObjectForKey:@"displaySettings"];
  self.otherMonitorCombo = [aDecoder decodeObjectForKey:@"otherMonitorCombo"];

  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:self.displaySettings forKey:@"displaySettings"];
  [aCoder encodeObject:self.otherMonitorCombo forKey:@"otherMonitorCombo"];
}

@end
