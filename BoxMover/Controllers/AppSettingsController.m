//
//  AppSettingsController.m
//  BoxMover
//
//  Created by Sheel Choksi on 7/22/14.
//  Copyright (c) 2014 Sheel Choksi. All rights reserved.
//

#import "AppSettingsController.h"
#import "DefaultAppSetting.h"

@implementation AppSettingsController

- (void)remove:(id)sender {
  DefaultAppSetting *selectedAppSetting = [self.selectedObjects firstObject];
  if (![selectedAppSetting isKindOfClass:[DefaultAppSetting class]]) {
    [super remove:sender];
  }
}

@end
