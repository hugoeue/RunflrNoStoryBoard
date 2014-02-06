//
//  MenuRefugio.h
//  RunflrNoStoryBoard
//
//  Created by Hugo Costa on 03/12/13.
//  Copyright (c) 2013 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuRefugio : UIViewController
- (IBAction)buttonFacebookLogin:(id)sender;
- (IBAction)buttonLingua:(id)sender;
- (IBAction)buttonPaginaPessoal:(id)sender;


@property (weak, nonatomic) IBOutlet UIImageView *imgUser;
@property (weak, nonatomic) IBOutlet UILabel *labelOla;
@property (weak, nonatomic) IBOutlet UILabel *labelVemVindo;
@property (weak, nonatomic) IBOutlet UILabel *labelUserName;
@property (weak, nonatomic) IBOutlet UILabel *labelLogin;

@property (weak, nonatomic) IBOutlet UIImageView *imgLogin;


@property (weak, nonatomic) IBOutlet UILabel *labelLingua;
@property (weak, nonatomic) IBOutlet UILabel *labelDfenicoes;
@property (weak, nonatomic) IBOutlet UILabel *labelMinhaCont;
@property (weak, nonatomic) IBOutlet UILabel *labelInicio;

@property (nonatomic, assign) id delegate;
- (IBAction)clickInicio:(id)sender;
- (IBAction)clickDefenicoes:(id)sender;
- (IBAction)clickLoginLogout:(id)sender;

-(void)carregarLingua;

@end
