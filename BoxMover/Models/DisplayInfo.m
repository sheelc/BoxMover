//
//  DisplayInfo.m
//  BoxMover
//
//  Created by Sheel Choksi on 7/21/14.
//  Copyright (c) 2014 Sheel Choksi. All rights reserved.
//

#import "DisplayInfo.h"

@implementation DisplayInfo

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super init];
  if (self) {
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.productId = [aDecoder decodeIntegerForKey:@"productId"];
  }

  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:self.name forKey:@"name"];
  [aCoder encodeInteger:self.productId forKey:@"productId"];
}

-(NSString *)description {
	return [NSString stringWithFormat:@"<%@: %p, Name: %@, ProductId: %ld>",
          NSStringFromClass([self class]), self, self.name, self.productId];
}

@end
