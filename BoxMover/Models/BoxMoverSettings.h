//
//  BoxMoverSettings.h
//  BoxMover
//
//  Created by Sheel Choksi on 7/20/14.
//  Copyright (c) 2014 Sheel Choksi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DisplaySetting.h"

@interface BoxMoverSettings : NSObject<NSCoding>

@property (strong, nonatomic) NSMutableArray *displaySettings;
@property (strong, nonatomic) NSMutableDictionary *otherMonitorCombo;

- (NSArray *)allHotKeyDictionaries;
- (CGRect)rectForKeyCombo:(NSDictionary *)keyCombo app:(NSString *)appName displayInfo:(DisplayInfo *)displayInfo;

@end
