//
//  CustomRecorderControl.m
//  BoxMover
//
//  Created by Sheel Choksi on 7/20/14.
//  Copyright (c) 2014 Sheel Choksi. All rights reserved.
//

#import "CustomRecorderControl.h"
#import "SizeSetting.h"

@implementation CustomRecorderControl

- (void)setObjectValue:(NSDictionary *)newObjectValue {
  if (![newObjectValue isKindOfClass:[SizeSetting class]]) {
    [super setObjectValue:newObjectValue];
  }
}

@end
