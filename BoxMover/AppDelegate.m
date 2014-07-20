//
//  AppDelegate.m
//  BoxMover
//
//  Created by Sheel Choksi on 7/19/14.
//  Copyright (c) 2014 Sheel Choksi. All rights reserved.
//

#import "AppDelegate.h"
#import "StatusItemController.h"
#import <IOKit/graphics/IOGraphicsLib.h>

@interface AppDelegate ()

@property (strong, nonatomic) StatusItemController *statusItemController;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  self.statusItemController = [[StatusItemController alloc] initWithDisplays:[self displays]];
}

- (NSMutableArray *)displays {
  NSMutableArray *displayInfos = [NSMutableArray new];
  for (NSScreen *screen in [NSScreen screens]) {
    CGDirectDisplayID displayID = (CGDirectDisplayID)[[screen deviceDescription][@"NSScreenNumber"] integerValue];
    NSDictionary *displayInfo = CFBridgingRelease(IODisplayCreateInfoDictionary(CGDisplayIOServicePort(displayID), 0));
    NSString *productIDKey = [NSString stringWithCString:kDisplayProductID encoding:NSUTF8StringEncoding];
    NSString *nameKey = [NSString stringWithCString:kDisplayProductName encoding:NSUTF8StringEncoding];

    [displayInfos addObject:@{@"productID":displayInfo[productIDKey], @"name":displayInfo[nameKey][@"id"]}];
  }

    return displayInfos;
}


@end
