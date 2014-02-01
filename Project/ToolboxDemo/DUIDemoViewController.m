//
//  DUIDemoViewController.m
//  ToolboxDemo
//
//  Created by Honza Dvorsky on 01/02/14.
//  Copyright (c) 2014 Honza Dvorsky. All rights reserved.
//

#import "DUIDemoViewController.h"
#import <DUIToolbox/DUIBlockActionSheet.h>
#import <DUIToolbox/DUIBlockAlertView.h>
#import <DUIToolbox/DUIActivityIndicatorItem.h>

@interface DUIDemoViewController ()

@property (nonatomic, strong) NSDictionary * toolNameActionBlocks;

@end

@implementation DUIDemoViewController

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
- (void) _prepToolNameActionBlocks
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    __weak DUIDemoViewController * weakSelf = self;
    
    self.toolNameActionBlocks =
    @{
      @"DUIBlockActionSheet": ^{
          
          void (^clickedBlock)(DUIBlockActionSheet*, NSInteger) = ^(DUIBlockActionSheet *actionSheet, NSInteger clickedIndex){
              NSString * message = [NSString stringWithFormat:@"You clicked index %i", clickedIndex];
              
              [[[DUIBlockAlertView alloc] initWithTitle:@"Nice!"
                                                message:message
                                           clickedBlock:nil
                                      cancelButtonTitle:nil
                                      otherButtonTitles:@"I know, dummy!", nil] show];
          };
          
          [[[DUIBlockActionSheet alloc] initWithTitle:@"Title"
                                         clickedBlock:clickedBlock
                                    cancelButtonTitle:@"Cancel"
                               destructiveButtonTitle:@"Destruct!"
                                    otherButtonTitles:@"Save", @"Something else", nil] showInView:weakSelf.view];
      },
      @"DUIBlockAlertView": ^{
          
          DUIBlockAlertView * alert = [[DUIBlockAlertView alloc] initWithTitle:@"Nice!"
                                                                       message:@"Yes, this is an Alert View!"
                                                                  clickedBlock:nil
                                                             cancelButtonTitle:nil
                                                             otherButtonTitles:@"I love it!", nil];
          [alert show];
      },
//      @"DUIActivityIndicatorItem": ^{
//          //TODO: add one to the navigation item for a couple of seconds
//      },
      @"default": ^{
          [[[DUIBlockAlertView alloc] initWithTitle:@"Aww :("
                                            message:@"I have not been implemented to show anything, apologies!"
                                       clickedBlock:nil
                                  cancelButtonTitle:@"Whatever..."
                                  otherButtonTitles:nil] show];
      }
      };
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
- (void) viewDidLoad
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    [super viewDidLoad];
    [self _prepToolNameActionBlocks];
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    NSString * toolName = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    
    void (^actionBlock)(void) = self.toolNameActionBlocks[toolName];
    if (!actionBlock) {
        actionBlock = self.toolNameActionBlocks[@"default"];
    }
    
    if (actionBlock) {
        actionBlock();
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
