//
//  BoxMover.m
//  BoxMover
//
//  Created by Sheel Choksi on 7/20/14.
//  Copyright (c) 2014 Sheel Choksi. All rights reserved.
//

#import "BoxMover.h"
#import "PTHotKeyCenter.h"
#import "PTHotKey+ShortcutRecorder.h"

@interface BoxMover ()

@property (strong, nonatomic) BoxMoverSettings *boxMoverSettings;
@property (strong, nonatomic) DisplayManager *displayManager;

@end

@implementation BoxMover

- (id)initWithBoxMoverSettings:(BoxMoverSettings *)settings displayManager:(DisplayManager *)displayManager {
  self = [super init];
  if (self) {
    self.boxMoverSettings = settings;
    self.displayManager = displayManager;
  }

  return self;
}

- (void)removeEvents {
  PTHotKeyCenter *hkCenter = [PTHotKeyCenter sharedCenter];
  for (PTHotKey *hk in [hkCenter allHotKeys]) {
    [hkCenter unregisterHotKey:hk];
  }
}

- (void)registerEvents {
  [self removeEvents];

  for (NSDictionary *keyCombo in [self.boxMoverSettings allHotKeyDictionaries]) {
    PTHotKey *hotKey = [PTHotKey hotKeyWithIdentifier:@"identifier"
                                             keyCombo:keyCombo
                                               target:self
                                               action:@selector(hotKeyCalled:)
                                           withObject:keyCombo];

    [[PTHotKeyCenter sharedCenter] registerHotKey:hotKey];
  }
}

- (void)hotKeyCalled:(PTHotKey *)hotKey {
  CFArrayRef windowList = CGWindowListCopyWindowInfo(kCGWindowListOptionOnScreenOnly|kCGWindowListExcludeDesktopElements, kCGNullWindowID);

  CFDictionaryRef topMostWindow = nil;

  for (NSInteger foundIndex = 0; foundIndex < CFArrayGetCount(windowList); foundIndex++) {
    CFDictionaryRef window = CFArrayGetValueAtIndex(windowList, foundIndex);
    CFNumberRef layer = CFDictionaryGetValue(window, kCGWindowLayer);
    int32_t base = 0;
    CFNumberRef topLayerNumber = CFNumberCreate(CFAllocatorGetDefault(), kCFNumberSInt32Type, &base);
    if (CFNumberCompare(layer, topLayerNumber, NULL) == kCFCompareEqualTo) {
      CFRelease(topLayerNumber);
      topMostWindow = window;
      break;
    }
    CFRelease(topLayerNumber);
  }

  CFNumberRef pidRef = CFDictionaryGetValue(topMostWindow, kCGWindowOwnerPID);
  pid_t windowPid;
  CFNumberGetValue(pidRef, kCFNumberIntType, &windowPid);
  CFRelease(pidRef);

  AXUIElementRef app = AXUIElementCreateApplication(windowPid);
  AXUIElementRef axWindow;
  AXUIElementCopyAttributeValue(app, kAXFocusedWindowAttribute, (CFTypeRef *)&axWindow);
  CFRelease(app);

  CFTypeRef origin;
  AXUIElementCopyAttributeValue(axWindow, kAXPositionAttribute, &origin);
  CGPoint origPoint;
  AXValueGetValue(origin, kAXValueCGPointType, &origPoint);
  CFRelease(origin);

  CFTypeRef size;
  AXUIElementCopyAttributeValue(axWindow, kAXSizeAttribute, &size);
  CGSize origSize;
  AXValueGetValue(size, kAXValueCGSizeType, &origSize);
  CFRelease(size);

  DisplayInfo *dispInfo = [self.displayManager displayContainingPoint:origPoint];

  NSString *appName = CFDictionaryGetValue(topMostWindow, kCGWindowOwnerName);
  NSDictionary *keyCombo = hotKey.object;

  CGRect normalizedRect;
  if ([self.boxMoverSettings.otherMonitorCombo isEqualTo:keyCombo]) {
    CGRect currentRect = {
      .origin = origPoint,
      .size = origSize
    };
    normalizedRect = [self.displayManager rectOnNextDisplay:currentRect];
  } else {
    CGRect newRect = [self.boxMoverSettings rectForKeyCombo:keyCombo app:appName displayInfo:dispInfo];
    normalizedRect = newRect;

    if (!CGRectEqualToRect(newRect, CGRectZero)) {
      normalizedRect = [self.displayManager normalizeRect:newRect forDisplay:dispInfo];
    }
  }

  if (!CGRectEqualToRect(normalizedRect, CGRectZero)) {
    CGPoint point = normalizedRect.origin;
    CFTypeRef position = (CFTypeRef)(AXValueCreate(kAXValueCGPointType, &point));
    AXUIElementSetAttributeValue(axWindow, kAXPositionAttribute, position);
    CFRelease(position);

    CGSize size = normalizedRect.size;
    CFTypeRef boxSize = (CFTypeRef)(AXValueCreate(kAXValueCGSizeType, &size));
    AXUIElementSetAttributeValue(axWindow, kAXSizeAttribute, boxSize);
    CFRelease(boxSize);
  }

  CFRelease(windowList);
  CFRelease(axWindow);
}

@end
