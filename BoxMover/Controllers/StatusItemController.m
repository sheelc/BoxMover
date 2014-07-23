//
//  StatusItemController.m
//  BoxMover
//
//  Created by Sheel Choksi on 7/19/14.
//  Copyright (c) 2014 Sheel Choksi. All rights reserved.
//

#import "StatusItemController.h"
#import "PreferencesController.h"

@interface StatusItemController ()

@property (strong, nonatomic) NSStatusItem *statusItem;
@property (strong, nonatomic) PreferencesController *preferencesController;
@property (strong, nonatomic) BoxMoverSettings *boxMoverSettings;
@property (strong, nonatomic) BoxMover *boxMover;

@end

@implementation StatusItemController

- (id)initWithBoxMoverSettings:(BoxMoverSettings *)settings boxMover:(BoxMover *)boxMover {
  self = [super init];
  if (self) {
    self.statusItem = [self createStatusItem];
    self.boxMoverSettings = settings;
    self.boxMover = boxMover;
  }

  return self;
}

- (NSStatusItem *)createStatusItem {
  NSStatusItem* item = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];

  item.menu = [self createMenuBar];
  item.title = @"BM";
  item.highlightMode = YES;

  return item;
}

- (NSMenu *)createMenuBar {
  NSMenu *menu = [[NSMenu alloc] init];

  NSMenuItem *menuItem;

  menuItem = [menu addItemWithTitle:@"Preferences" action:@selector(openPreferences:) keyEquivalent:@""];
  menuItem.target = self;

  [menu addItem:[NSMenuItem separatorItem]];

  menuItem = [menu addItemWithTitle:@"Quit" action:@selector(closeApplication:) keyEquivalent:@""];
  menuItem.target = self;

  return menu;
}

- (void)openPreferences:(id)sender {
  if(!self.preferencesController) {
    [self.boxMover removeEvents];
    self.preferencesController = [[PreferencesController alloc] initWithBoxMoverSettings:self.boxMoverSettings];
    [[self.preferencesController window] setLevel: NSPopUpMenuWindowLevel];
    [self.preferencesController showWindow:self];
    [[NSNotificationCenter defaultCenter] addObserverForName:NSWindowWillCloseNotification
                                                      object:[self.preferencesController window]
                                                       queue:nil
                                                  usingBlock:^(NSNotification *notification) {
                                                    self.preferencesController = nil;
                                                    [self.boxMover registerEvents];
                                                  }];
  }
}


- (void)closeApplication:(id)sender {
  [NSApp terminate:self];
}

@end