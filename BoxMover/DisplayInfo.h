//
//  DisplayInfo.h
//  BoxMover
//
//  Created by Sheel Choksi on 7/21/14.
//  Copyright (c) 2014 Sheel Choksi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DisplayInfo : NSObject

@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger productId;
@property (assign, nonatomic) CGRect frame;

@end
