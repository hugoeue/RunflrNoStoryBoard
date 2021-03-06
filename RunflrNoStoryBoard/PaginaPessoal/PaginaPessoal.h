//
//  PaginaPessoal.h
//  RunflrNoStoryBoard
//
//  Created by Hugo Costa on 16/12/13.
//  Copyright (c) 2013 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FXImageView.h"

@interface PaginaPessoal :  UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet FXImageView *imgUser;

@property (weak, nonatomic) IBOutlet UILabel *labelName;
- (IBAction)clickLoginLogout:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *buttonLogin;

- (IBAction)clickBack:(id)sender;

@property (nonatomic , assign) id delegate;




- (IBAction)clickReceberNotifacoes:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *botaoSelectNoti;


@property (weak, nonatomic) IBOutlet UIImageView *botaoSelectNews;
@property (weak, nonatomic) IBOutlet UIImageView *butaoSelectJuntar;

- (IBAction)clickBuscarImagem:(id)sender;

@property UIImagePickerController *picker;
@property UIImageView * selectedImage;

- (IBAction)clickJuntarContas:(id)sender;
- (IBAction)clickNewsLetter:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonSelecionarImagem;
@property (weak, nonatomic) IBOutlet UIView *viewPretaGrande;
@property (weak, nonatomic) IBOutlet UIButton *buttonMenu;


@property (weak, nonatomic) IBOutlet UIButton *buttonJuntarContas;

//////////////// para a lingua

@property (weak, nonatomic) IBOutlet UILabel *labelConectar;
@property (weak, nonatomic) IBOutlet UILabel *labelNewsletter;
@property (weak, nonatomic) IBOutlet UILabel *labelMudarFoto;
@property (weak, nonatomic) IBOutlet UILabel *labelMinhaConta;
@property (weak, nonatomic) IBOutlet UILabel *labelReceberNotificacoes;


@property (weak, nonatomic) IBOutlet UIImageView *imagemTopo;

@property (weak, nonatomic) IBOutlet UIButton *buttonNotificacoes;

@property (weak, nonatomic) IBOutlet UIButton *buttonNewsletter;


@end
