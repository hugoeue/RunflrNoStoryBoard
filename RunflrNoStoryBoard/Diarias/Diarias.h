//
//  Diarias.h
//  RunflrNoStoryBoard
//
//  Created by Hugo Costa on 04/12/13.
//  Copyright (c) 2013 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FXImageView.h"

@interface Diarias : UIViewController

- (IBAction)clickBack:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segControl;
@property (weak, nonatomic) IBOutlet UILabel *labelTitleRestaurnat;
@property (weak, nonatomic) IBOutlet UILabel *labelLocalisacao;


-(void)loadRestaurant:(Restaurant *)rest;

- (IBAction)selecteSegControl:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *container;
- (IBAction)clickAddFavorito:(id)sender;
@property (weak, nonatomic) IBOutlet FXImageView *imagemRestaurante;
- (IBAction)chamarMapa:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *labelCosinhas;

@end
