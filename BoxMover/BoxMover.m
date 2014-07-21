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

@end

@implementation BoxMover

- (id)initWithBoxMoverSettings:(BoxMoverSettings *)settings {
  self = [super init];
  if (self) {
    self.boxMoverSettings = settings;
  }

  return self;
}

- (void)registerEvents {
  PTHotKeyCenter *hkCenter = [PTHotKeyCenter sharedCenter];
  for (PTHotKey *hk in [hkCenter allHotKeys]) {
    [hkCenter unregisterHotKey:hk];
  }

  for (NSDictionary *keyCombo in [self.boxMoverSettings allHotKeyDictionaries]) {
    PTHotKey *hotKey = [PTHotKey hotKeyWithIdentifier:@"identifier"
                                             keyCombo:keyCombo
                                               target:self
                                               action:@selector(hotKeyCalled)
                                           withObject:keyCombo];

    [hkCenter registerHotKey:hotKey];
  }
}

- (void)hotKeyCalled {
  CFArrayRef windowList = CGWindowListCopyWindowInfo(kCGWindowListOptionOnScreenOnly|kCGWindowListExcludeDesktopElements, kCGNullWindowID);

  CFDictionaryRef topMostWindow = nil;
  NSInteger foundIndex = 0;
  for (; foundIndex < CFArrayGetCount(windowList); foundIndex++) {
    CFDictionaryRef window = CFArrayGetValueAtIndex(windowList, foundIndex);
    CFNumberRef layer = CFDictionaryGetValue(window, kCGWindowLayer);
    int32_t base = 0;
    CFNumberRef topLayerNumber = CFNumberCreate(CFAllocatorGetDefault(), kCFNumberSInt32Type, &base);
    if (CFNumberCompare(layer, topLayerNumber, NULL) == kCFCompareEqualTo) {
      topMostWindow = window;
      break;
    }
  }

  NSLog(@"================> %@", topMostWindow);

  CFNumberRef pidRef = CFDictionaryGetValue(topMostWindow, kCGWindowOwnerPID);
  pid_t windowPid;
  CFNumberGetValue(pidRef, kCFNumberIntType, &windowPid);

  AXUIElementRef app = AXUIElementCreateApplication(windowPid);

  NSArray *result;
  CFArrayRef resultArr = CFBridgingRetain(result);

  AXUIElementCopyAttributeNames(app, &resultArr);

  AXUIElementRef axWindow;
  AXUIElementCopyAttributeValue(app, kAXFocusedWindowAttribute, (CFTypeRef *)&axWindow);

  NSLog(@"================> %@", axWindow);

  CGPoint point = {100.0, 100.0};
  CFTypeRef position = (CFTypeRef)(AXValueCreate(kAXValueCGPointType, (const void *)&point));
  AXUIElementSetAttributeValue(axWindow, kAXPositionAttribute, (CFTypeRef)position);
}

@end
