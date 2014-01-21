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


@property (weak, nonatomic) IBOutlet UILabel *labelTitulo;
@property (weak, nonatomic) IBOutlet UILabel *LabelOquePensas;
@property (weak, nonatomic) IBOutlet UILabel *labelClassifica;
@property (weak, nonatomic) IBOutlet UILabel *labelPartilha;
@property (weak, nonatomic) IBOutlet UILabel *labelSMS;
@property (weak, nonatomic) IBOutlet UILabel *LabelFacebook;
@property (weak, nonatomic) IBOutlet UILabel *labelEmail;


- (IBAction)clickClassifica:(id)sender;
- (IBAction)clickEmailAmigos:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *imagemTopo;

- (IBAction)clickFacebook:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonFacebook;



@end
