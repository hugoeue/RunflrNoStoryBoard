//
//  Defenicoes.h
//  RunflrNoStoryBoard
//
//  Created by Hugo Costa on 25/12/13.
//  Copyright (c) 2013 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMessageComposeViewController.h>
#import <MessageUI/MessageUI.h>

@interface Defenicoes : UIViewController<MFMessageComposeViewControllerDelegate,UITextFieldDelegate,MFMailComposeViewControllerDelegate>

- (IBAction)ClickAnterior:(id)sender;
- (IBAction)clickFeedBack:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *labelTermos;
@property (weak, nonatomic) IBOutlet UILabel *labelPolitica;
@property (weak, nonatomic) IBOutlet UILabel *labelSobre;
@property (weak, nonatomic) IBOutlet UILabel *labelFeedBack;

@property (weak, nonatomic) IBOutlet UILabel *labelDefeniçoes;

@property (weak, nonatomic) IBOutlet UIView *viewPretaGrande;
@property (weak, nonatomic) IBOutlet UIButton *buttonMenu;

@property (weak, nonatomic) IBOutlet UIImageView *imagemTopo;
@property (weak, nonatomic) IBOutlet UIView *container;

@end
