//
//  DisplaySetting.h
//  BoxMover
//
//  Created by Sheel Choksi on 7/20/14.
//  Copyright (c) 2014 Sheel Choksi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DisplaySetting : NSObject<NSCoding>

@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger productId;
@property (strong, nonatomic) NSMutableArray *appSettings;

@end
