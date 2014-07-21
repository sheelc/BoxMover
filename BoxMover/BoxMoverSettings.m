//
//  BoxMoverSettings.m
//  BoxMover
//
//  Created by Sheel Choksi on 7/20/14.
//  Copyright (c) 2014 Sheel Choksi. All rights reserved.
//

#import "BoxMoverSettings.h"

@implementation BoxMoverSettings

- (id)init {
  self = [super init];
  if (self) {
    self.displaySettings = [NSMutableArray new];
  }

  return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
  self.displaySettings = [aDecoder decodeObjectForKey:@"displaySettings"];

  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:self.displaySettings forKey:@"displaySettings"];
}

@end
