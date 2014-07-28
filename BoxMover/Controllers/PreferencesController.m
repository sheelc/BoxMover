//
//  PreferencesController.m
//  BoxMover
//
//  Created by Sheel Choksi on 7/19/14.
//  Copyright (c) 2014 Sheel Choksi. All rights reserved.
//

#import "PreferencesController.h"
#import "BoxMoverSettings.h"
#import "SRRecorderControl.h"
#import "SRKeyEquivalentTransformer.h"
#import "CustomRecorderControl.h"
#import "DisplaySetting.h"
#import "AppSetting.h"
#import "SizeSetting.h"

@interface PreferencesController ()<NSTableViewDelegate>

@property (strong, nonatomic) BoxMoverSettings *boxMoverSettings;
@property (weak) IBOutlet SRRecorderControl *otherMonitorCombo;

@end

@implementation PreferencesController

- (id)initWithBoxMoverSettings:(BoxMoverSettings *)settings {
  self = [super initWithWindowNibName:NSStringFromClass([self class]) owner:self];
  if (self) {
    self.boxMoverSettings = settings;
  }
  return self;
}

- (void)awakeFromNib {
  [super awakeFromNib];

  [self.otherMonitorCombo bind:NSValueBinding toObject:self.boxMoverSettings withKeyPath:@"otherMonitorCombo" options:nil];
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
  NSView *view = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];

  if ([tableColumn.identifier isEqualToString:@"ShortcutIdentifier"]) {
    [(SRRecorderControl *)view bind:NSValueBinding toObject:[self sizeSettingForRow:row] withKeyPath:@"srKeyCombo" options:nil];
  }

  return view;
}

- (SizeSetting *)sizeSettingForRow:(NSInteger)row {
  DisplaySetting *displaySetting = self.boxMoverSettings.displaySettings[self.displaysTable.selectedRow];
  AppSetting *appSetting = displaySetting.appSettings[self.appsTable.selectedRow];
  return appSetting.sizeSettings[row];
}

@end
