//
//  SizeSetting.h
//  BoxMover
//
//  Created by Sheel Choksi on 7/20/14.
//  Copyright (c) 2014 Sheel Choksi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SizeSetting : NSObject<NSCopying>

@property (strong, nonatomic) NSMutableDictionary *coordinates;
@property (assign, nonatomic) BOOL editable;
@property (strong, nonatomic) NSDictionary *srKeyCombo;

@end
