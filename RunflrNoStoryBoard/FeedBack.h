//
//  FeedBack.h
//  RunflrNoStoryBoard
//
//  Created by Hugo Costa on 29/12/13.
//  Copyright (c) 2013 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMessageComposeViewController.h>
#import <MessageUI/MessageUI.h>

@interface FeedBack : UIViewController <MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate>
- (IBAction)clickSMS:(id)sender;
- (IBAction)clickDisnosOQuePensas:(id)sender;

@end
