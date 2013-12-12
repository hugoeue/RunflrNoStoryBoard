//
//  LanguageViewController.h
//  RunflrNoStoryBoard
//
//  Created by Hugo Costa on 07/12/13.
//  Copyright (c) 2013 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LanguageViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *buttonClose;
- (IBAction)closeClick:(id)sender;
- (IBAction)frClick:(id)sender;
- (IBAction)esClick:(id)sender;
- (IBAction)enClick:(id)sender;
- (IBAction)ptClick:(id)sender;
- (IBAction)deClick:(id)sender;
- (IBAction)itClick:(id)sender;

// imagens selecionadas
@property (weak, nonatomic) IBOutlet UIImageView *imgPT;
@property (weak, nonatomic) IBOutlet UIImageView *imgEN;
@property (weak, nonatomic) IBOutlet UIImageView *imgFR;
@property (weak, nonatomic) IBOutlet UIImageView *imgES;
@property (weak, nonatomic) IBOutlet UIImageView *imgDE;
@property (weak, nonatomic) IBOutlet UIImageView *imgIT;


@end
