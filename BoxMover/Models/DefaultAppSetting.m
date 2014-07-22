//
//  DefaultAppSetting.m
//  BoxMover
//
//  Created by Sheel Choksi on 7/21/14.
//  Copyright (c) 2014 Sheel Choksi. All rights reserved.
//

#import "DefaultAppSetting.h"

NSString *const kDefaultAppName = @"Default";

@implementation DefaultAppSetting

- (id)init {
  self = [super init];
  if (self) {
    self.name = kDefaultAppName;
  }

  return self;
}

@end
