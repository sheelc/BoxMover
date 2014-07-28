//
//  DisplayManager.h
//  BoxMover
//
//  Created by Sheel Choksi on 7/21/14.
//  Copyright (c) 2014 Sheel Choksi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DisplayInfo.h"

@interface DisplayManager : NSObject

@property (strong, nonatomic, readonly) NSArray *displays;

- (void)refreshDisplays;
- (DisplayInfo *)displayContainingPoint:(CGPoint)point;
- (CGRect)normalizeRect:(CGRect)rect forDisplay:(DisplayInfo *)displayInfo;
- (CGRect)rectOnNextDisplay:(CGRect)currentRect;

@end
