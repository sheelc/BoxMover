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
    [self refreshDisplays];
  }

  return _displays;
}

- (void)refreshDisplays {
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

  self.displays = displayInfos;
}

- (DisplayInfo *)displayContainingPoint:(CGPoint)point {
  DisplayInfo *foundDisplay = nil;
  for (DisplayInfo *displayInfo in self.displays) {
    if (CGRectGetMinX(displayInfo.frame) <= point.x && point.x < CGRectGetMaxX(displayInfo.frame)) {
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

- (CGRect)rectOnNextDisplay:(CGRect)currentRect {
  DisplayInfo *currentDisplay = [self displayContainingPoint:currentRect.origin];
  DisplayInfo *rightmostDisplay = [self rightmostDisplay];
  CGRect nextDisplayFrame;
  if (currentDisplay == rightmostDisplay) {
    nextDisplayFrame = [[self leftmostDisplay] frame];
  } else {
    CGPoint originOnNextDisplay = {
      .y = currentRect.origin.y,
      .x = CGRectGetMaxX(currentDisplay.frame) + 1.0,
    };

    nextDisplayFrame = [[self displayContainingPoint:originOnNextDisplay] frame];
  }

  CGFloat xOffset = (currentRect.origin.x - currentDisplay.frame.origin.x) / currentDisplay.frame.size.width;
  CGFloat yOffset = (currentRect.origin.y - currentDisplay.frame.origin.y) / currentDisplay.frame.size.height;

  CGRect newRect = {
    .origin.x = xOffset * nextDisplayFrame.size.width + nextDisplayFrame.origin.x,
    .origin.y = yOffset * nextDisplayFrame.size.height + nextDisplayFrame.origin.y,
    .size = currentRect.size
  };

  return newRect;
}

- (DisplayInfo *)rightmostDisplay {
  DisplayInfo *rightmost;
  for (DisplayInfo *dispInfo in self.displays) {
    if (CGRectGetMaxX(dispInfo.frame) > CGRectGetMaxX(rightmost.frame)) {
      rightmost = dispInfo;
    }
  }

  return rightmost;
}

- (DisplayInfo *)leftmostDisplay {
  DisplayInfo *leftmost;
  for (DisplayInfo *dispInfo in self.displays) {
    if (CGRectGetMinX(dispInfo.frame) <= CGRectGetMinX(leftmost.frame)) {
      leftmost = dispInfo;
    }
  }

  return leftmost;
}

@end
