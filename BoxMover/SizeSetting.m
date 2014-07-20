//
//  SizeSetting.m
//  BoxMover
//
//  Created by Sheel Choksi on 7/20/14.
//  Copyright (c) 2014 Sheel Choksi. All rights reserved.
//

#import "SizeSetting.h"

@implementation SizeSetting

- (id)init {
  self = [super init];
  if (self) {
    self.coordinates = [NSMutableDictionary dictionaryWithDictionary:@{@"x": @0, @"y": @0, @"w": @0, @"h": @0}];
  }

  return self;
}

- (id)copyWithZone:(NSZone *)zone {
  SizeSetting *sizeSetting = [SizeSetting new];
  sizeSetting.coordinates = [self.coordinates copyWithZone:zone];
  return sizeSetting;
}

- (NSUInteger)count {
  return 0;
}

@end
