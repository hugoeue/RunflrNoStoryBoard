//
//  FeedBack.h
//  RunflrNoStoryBoard
//
//  Created by Hugo Costa on 29/12/13.
//  Copyright (c) 2013 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMessageComposeViewController.h>

@interface FeedBack : UIViewController <MFMessageComposeViewControllerDelegate>
- (IBAction)clickSMS:(id)sender;

@end
