//
//  Login.h
//  RunflrNoStoryBoard
//
//  Created by Hugo Costa on 04/12/13.
//  Copyright (c) 2013 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Login : UIViewController
- (IBAction)loginButton:(id)sender;

- (IBAction)popAnterior:(id)sender;

- (IBAction)clickRegistoRundlr:(id)sender;


@property (weak, nonatomic) IBOutlet UITextField *textFieldemail;

@property (weak, nonatomic) IBOutlet UITextField *textFieldPassword;
- (IBAction)clickSubmeter:(id)sender;
- (IBAction)clickRecuperarPass:(id)sender;

-(void)close;



// para as traduções

@property (weak, nonatomic) IBOutlet UILabel *labelTitulo;
@property (weak, nonatomic) IBOutlet UILabel *labelSubTitulo;
@property (weak, nonatomic) IBOutlet UILabel *labelOu;
@property (weak, nonatomic) IBOutlet UIButton *buttonIniciar;
@property (weak, nonatomic) IBOutlet UIButton *buttonLogin;
@property (weak, nonatomic) IBOutlet UIButton *buttonRegisto;
@property (weak, nonatomic) IBOutlet UIButton *buttonRecuperar;
@property (weak, nonatomic) IBOutlet UITextField *fieldEmail;
@property (weak, nonatomic) IBOutlet UITextField *fieldPass;


@end
