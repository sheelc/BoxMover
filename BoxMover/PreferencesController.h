//
//  PreferencesController.h
//  BoxMover
//
//  Created by Sheel Choksi on 7/19/14.
//  Copyright (c) 2014 Sheel Choksi. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "BoxMoverSettings.h"

@interface PreferencesController : NSWindowController

- (id)initWithBoxMoverSettings:(BoxMoverSettings *)settings;
@property (weak) IBOutlet NSTableView *shortcutTable;
@property (weak) IBOutlet NSTableView *displaysTable;
@property (weak) IBOutlet NSTableView *appsTable;

@end
