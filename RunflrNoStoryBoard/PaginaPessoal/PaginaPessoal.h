//
//  PaginaPessoal.h
//  RunflrNoStoryBoard
//
//  Created by Hugo Costa on 16/12/13.
//  Copyright (c) 2013 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaginaPessoal :  UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imgUser;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
- (IBAction)clickLoginLogout:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *buttonLogin;

- (IBAction)clickBack:(id)sender;

@property (nonatomic , assign) id delegate;


- (IBAction)clickReceberNotifacoes:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *botaoSelectNoti;

- (IBAction)clickReceberNewsletter:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *botaoSelectNews;
@property (weak, nonatomic) IBOutlet UIImageView *butaoSelectJuntar;

- (IBAction)clickBuscarImagem:(id)sender;

@property UIImagePickerController *picker;
@property UIImageView * selectedImage;

- (IBAction)clickJuntarContas:(id)sender;
- (IBAction)clickNewsLetter:(id)sender;


@end
