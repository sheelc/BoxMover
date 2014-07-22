//
//  BoxMoverSettings.m
//  BoxMover
//
//  Created by Sheel Choksi on 7/20/14.
//  Copyright (c) 2014 Sheel Choksi. All rights reserved.
//

#import "BoxMoverSettings.h"
#import "DisplaySetting.h"
#import "AppSetting.h"
#import "SizeSetting.h"

@implementation BoxMoverSettings

- (id)init {
  self = [super init];
  if (self) {
    self.displaySettings = [NSMutableArray new];
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

  return [hotKeys allObjects];
}

- (CGRect)rectForKeyCombo:(NSDictionary *)keyCombo app:(NSString *)appName displayId:(NSInteger)displayId {
  return CGRectMake(100.0, 100.0, 1000.0, 800.0);
}

- (id)initWithCoder:(NSCoder *)aDecoder {
  self.displaySettings = [aDecoder decodeObjectForKey:@"displaySettings"];

  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:self.displaySettings forKey:@"displaySettings"];
}

@end
