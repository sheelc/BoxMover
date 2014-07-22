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
    self.editable = YES;
    self.srKeyCombo = [NSDictionary new];
  }

  return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super init];
  if (self) {
    self.coordinates = [aDecoder decodeObjectForKey:@"coordinates"];
    self.editable = [aDecoder decodeBoolForKey:@"editable"];
    self.srKeyCombo = [aDecoder decodeObjectForKey:@"srKeyCombo"];
  }

  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:self.coordinates forKey:@"coordinates"];
  [aCoder encodeBool:self.editable forKey:@"editable"];
  [aCoder encodeObject:self.srKeyCombo forKey:@"srKeyCombo"];
}

@end
