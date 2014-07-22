//
//  DisplayManager.m
//  BoxMover
//
//  Created by Sheel Choksi on 7/21/14.
//  Copyright (c) 2014 Sheel Choksi. All rights reserved.
//

#import "DisplayManager.h"

@interface DisplayManager ()

@property (strong, nonatomic, readwrite) NSArray *displays;

@end

@implementation DisplayManager

- (NSArray *)displays {
  if (!_displays) {
    NSMutableArray *displayInfos = [NSMutableArray new];
    for (NSScreen *screen in [NSScreen screens]) {
      CGDirectDisplayID displayID = (CGDirectDisplayID)[[screen deviceDescription][@"NSScreenNumber"] integerValue];
      NSDictionary *displayInfo = CFBridgingRelease(IODisplayCreateInfoDictionary(CGDisplayIOServicePort(displayID), 0));
      NSString *productIDKey = [NSString stringWithCString:kDisplayProductID encoding:NSUTF8StringEncoding];
      NSString *nameKey = [NSString stringWithCString:kDisplayProductName encoding:NSUTF8StringEncoding];

      DisplayInfo *info = [DisplayInfo new];
      info.productId = [displayInfo[productIDKey] integerValue];
      info.name = displayInfo[nameKey][@"id"];
      info.frame = screen.frame;
      [displayInfos addObject:info];
    }

    _displays = displayInfos;
  }

  return _displays;
}

- (DisplayInfo *)displayContainingPoint:(CGPoint)point {
  DisplayInfo *foundDisplay = nil;
  for (DisplayInfo *displayInfo in self.displays) {
    if (CGRectContainsPoint(displayInfo.frame, point)) {
      foundDisplay = displayInfo;
    }
  }

  return foundDisplay;
}

- (CGRect)normalizeRect:(CGRect)rect forDisplay:(DisplayInfo *)displayInfo {
  CGRect normalizedRect = rect;
  normalizedRect.origin.x += CGRectGetMinX(displayInfo.frame);
  normalizedRect.origin.y += CGRectGetMinY(displayInfo.frame);
  return normalizedRect;
}

@end
