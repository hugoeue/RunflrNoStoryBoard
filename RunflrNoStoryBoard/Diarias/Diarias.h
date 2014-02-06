//
//  Diarias.h
//  RunflrNoStoryBoard
//
//  Created by Hugo Costa on 04/12/13.
//  Copyright (c) 2013 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FXImageView.h"
#import <CoreLocation/CoreLocation.h>
#import <MessageUI/MessageUI.h> 
#import "iCarousel.h"



@interface Diarias : UIViewController <MFMailComposeViewControllerDelegate,UIActionSheetDelegate,UIScrollViewDelegate>

@property CLLocationManager * locationManager;

- (IBAction)clickBack:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *labelTitleRestaurnat;
@property (weak, nonatomic) IBOutlet UILabel *labelLocalisacao;


-(void)loadRestaurant:(Restaurant *)rest;



@property (weak, nonatomic) IBOutlet UIView *container;
- (IBAction)clickAddFavorito:(id)sender;
@property (weak, nonatomic) IBOutlet FXImageView *imagemRestaurante;
- (IBAction)chamarMapa:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *labelCosinhas;


@property (weak, nonatomic) IBOutlet UIButton *buttonSeguir;
- (IBAction)clickLigar:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *labelDistancia;


@property (nonatomic , assign) id delegate;

-(void)setSeguir:(BOOL) seguir;



@property (weak, nonatomic) IBOutlet UIButton *buttonLigar;
- (IBAction)clickDiarias:(id)sender;

- (IBAction)clickMainPopup:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *viewImagemRest;

@property (weak, nonatomic) IBOutlet UIView *viewBotoes;
@property (weak, nonatomic) IBOutlet UIView *imgFade;
@property (weak, nonatomic) IBOutlet UIView *viewParaTaparOlhos;

@property (weak, nonatomic) IBOutlet iCarousel *carousel;
@property (nonatomic, strong) NSMutableArray *items;
@property (weak, nonatomic) IBOutlet UIToolbar *navBarBotton;

// para os botoes da barra de baixo
@property (weak, nonatomic) IBOutlet UIBarButtonItem *buttonLinguas;




@end
