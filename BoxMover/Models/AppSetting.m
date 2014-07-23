//
//  AppSetting.m
//  BoxMover
//
//  Created by Sheel Choksi on 7/20/14.
//  Copyright (c) 2014 Sheel Choksi. All rights reserved.
//

#import "AppSetting.h"

@implementation AppSetting

- (id)init {
  self = [super init];
  if (self) {
    self.sizeSettings = [NSMutableArray new];
    self.name = @"New Name";
    self.editable = YES;
  }

  return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super init];
  if (self) {
    self.sizeSettings = [aDecoder decodeObjectForKey:@"sizeSettings"];
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.editable = [aDecoder decodeBoolForKey:@"editable"];
  }

  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:self.sizeSettings forKey:@"sizeSettings"];
  [aCoder encodeObject:self.name forKey:@"name"];
  [aCoder encodeBool:self.editable forKey:@"editable"];
}

@end
