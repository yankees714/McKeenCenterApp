//
//  McKSecondViewController.h
//  McKeenCenterApp
//
//  Created by Evan Hoyt on 5/6/13.
//  Copyright (c) 2013 Andrew Daniels and Evan Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "McKOpportunityInfo.h"

@interface McKSecondViewController : UITableViewController

@property (nonatomic) NSMutableArray * arrayOfObjects;
@property (strong, nonatomic) McKOpportunityInfo * oppInfoVC;

//@property (strong, nonatomic) IBOutlet UISegmentedControl *toggleSwitch;

//- (IBAction)switchToggled:(id)sender;
- (IBAction)toggleModeButton:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIButton *toggleButtonOutlet;

@end
