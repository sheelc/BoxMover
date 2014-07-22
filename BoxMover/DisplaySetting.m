//
//  DisplaySetting.m
//  BoxMover
//
//  Created by Sheel Choksi on 7/20/14.
//  Copyright (c) 2014 Sheel Choksi. All rights reserved.
//

#import "DisplaySetting.h"
#import "DefaultAppSetting.h"

@implementation DisplaySetting

- (id)init {
  self = [super init];
  if (self) {
    self.appSettings = [NSMutableArray new];
    [self.appSettings addObject:[DefaultAppSetting new]];

    self.displayInfo = [DisplayInfo new];
  }

  return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super init];
  if (self) {
    self.appSettings = [aDecoder decodeObjectForKey:@"appSettings"];
    self.displayInfo = [aDecoder decodeObjectForKey:@"displayInfo"];
  }

  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:self.appSettings forKey:@"appSettings"];
  [aCoder encodeObject:self.displayInfo forKey:@"displayInfo"];
}

- (NSString *)name {
  return self.displayInfo.name;
}

- (void)setName:(NSString *)name {
  self.displayInfo.name = name;
}

- (NSInteger)productId {
  return self.displayInfo.productId;
}

- (void)setProductId:(NSInteger)productId {
  self.displayInfo.productId = productId;
}

@end
