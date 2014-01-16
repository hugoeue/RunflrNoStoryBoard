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
- (IBAction)clickMenu:(id)sender;




@property (weak, nonatomic) IBOutlet UILabel *labelLingua;
@property (weak, nonatomic) IBOutlet UILabel *labelDfenicoes;
@property (weak, nonatomic) IBOutlet UILabel *labelMinhaCont;
@property (weak, nonatomic) IBOutlet UILabel *labelInicio;

@property (nonatomic, assign) id delegate;
- (IBAction)clickInicio:(id)sender;
- (IBAction)clickDefenicoes:(id)sender;
-(void)carregarLingua;

@end
