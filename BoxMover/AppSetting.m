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
  }

  return self;
}

@end
