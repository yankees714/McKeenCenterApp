//
//  McKEventInfoViewController.m
//  McKeenCenterApp
//
//  Created by Evan Hoyt on 5/5/13.
//  Copyright (c) 2013 Andrew Daniels and Evan Hoyt. All rights reserved.
//

#import "McKEventInfoViewController.h"

@interface McKEventInfoViewController ()

@end

@implementation McKEventInfoViewController

@synthesize cellSelected;
@synthesize eventInfo;
@synthesize emailAddress;

@synthesize eventTitle;
@synthesize eventSubtitle;
@synthesize eventDetails;
@synthesize signupButton;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    signupButton.hidden = YES;
    [eventTitle setText: [[eventInfo objectAtIndex:cellSelected]objectAtIndex:0 ]];
    [eventSubtitle setText: [[eventInfo objectAtIndex:cellSelected]objectAtIndex:1 ]];

    if ([[[eventInfo objectAtIndex:cellSelected]objectAtIndex:1 ]characterAtIndex:0] == '('){
        [eventSubtitle setText:@""];
    }
    if ([[eventInfo objectAtIndex:cellSelected]count] > 2){
        [eventDetails setText: [[eventInfo objectAtIndex:cellSelected]objectAtIndex:2]];
    } else [eventDetails setText:@"There is no additional information about this event. Please contact the McKeenCenter for more information."];
    //
    if ([[eventInfo objectAtIndex:cellSelected]objectAtIndex:2]){
        char buttonMode = [[[eventInfo objectAtIndex:cellSelected]objectAtIndex:3]characterAtIndex:0];
        if ((buttonMode == 'y') || (buttonMode == 'Y')){
            signupButton.hidden = NO;
        } else signupButton.hidden = YES;
    } else signupButton.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signUp:(UIButton *)sender {
    NSString *fourthLine = [[NSString alloc]init];
    if ([eventInfo count] > 3){
        fourthLine = [[eventInfo objectAtIndex:cellSelected]objectAtIndex:3];
    } else fourthLine = @"";
    NSArray *arrayOfFourthLine = [fourthLine componentsSeparatedByString:@" "];
    if ([arrayOfFourthLine count]>1){
        emailAddress = [arrayOfFourthLine objectAtIndex:1];
    } else emailAddress = @"";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:@"email to signup or for more information"
                                                   delegate:self cancelButtonTitle:@"cancel" otherButtonTitles: @"email", nil];
    [alert show];

}
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1){
        if ([MFMailComposeViewController canSendMail]) {
			//setup mailViewController
			MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
			mailViewController.mailComposeDelegate = self;
			
			//set fields of message
			NSArray *toRecipients = [[NSArray alloc]initWithObjects:emailAddress, nil];
			[mailViewController setToRecipients:toRecipients]; //don't forget to change this
			[mailViewController setSubject:[@"Mobile App: " stringByAppendingString:[[eventInfo objectAtIndex:cellSelected]objectAtIndex:0]]];
		
			
			//present mail interface
			[self presentViewController:mailViewController animated:YES completion:nil];
        }else {
            
            NSLog(@"Device is unable to send email in its current state.");
        }
    }
}
//MFMailComposeViewControllerDelegate method
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
	if (result==MFMailComposeResultSent) {
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sent!"
                                                        message:@"Your message was sent successfully"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
		[alert show];
	}
	[self dismissViewControllerAnimated:YES completion:nil];
}
@end
