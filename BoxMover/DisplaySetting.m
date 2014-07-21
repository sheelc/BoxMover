//
//  DisplaySetting.m
//  BoxMover
//
//  Created by Sheel Choksi on 7/20/14.
//  Copyright (c) 2014 Sheel Choksi. All rights reserved.
//

#import "DisplaySetting.h"

@implementation DisplaySetting

- (id)init {
  self = [super init];
  if (self) {
    self.appSettings = [NSMutableArray new];
  }

  return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super init];
  if (self) {
    self.appSettings = [aDecoder decodeObjectForKey:@"appSettings"];
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.productId = [aDecoder decodeIntegerForKey:@"productId"];
  }

  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:self.appSettings forKey:@"appSettings"];
  [aCoder encodeObject:self.name forKey:@"name"];
  [aCoder encodeInteger:self.productId forKey:@"productId"];
}

@end
