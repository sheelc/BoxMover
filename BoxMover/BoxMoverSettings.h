//
//  BoxMoverSettings.h
//  BoxMover
//
//  Created by Sheel Choksi on 7/20/14.
//  Copyright (c) 2014 Sheel Choksi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BoxMoverSettings : NSObject<NSCoding>

@property (strong, nonatomic) NSMutableArray *displaySettings;

- (NSArray *)allHotKeyDictionaries;
- (CGRect)rectForKeyCombo:(NSDictionary *)keyCombo app:(NSString *)appName displayId:(NSInteger)displayId;

@end
