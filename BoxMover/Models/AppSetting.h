//
//  AppSetting.h
//  BoxMover
//
//  Created by Sheel Choksi on 7/20/14.
//  Copyright (c) 2014 Sheel Choksi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppSetting : NSObject<NSCoding>

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSMutableArray *sizeSettings;
@property (assign, nonatomic) BOOL editable;

@end
