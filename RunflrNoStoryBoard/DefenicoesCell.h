//
//  pesquiseCell.h
//  DinamicTable
//
//  Created by Hugo Costa on 31/01/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DefenicoesCell : UITableViewCell <UITextFieldDelegate>

@property (nonatomic , assign) id delegate;
- (IBAction)clickMensagem:(id)sender;
- (IBAction)clickEmail:(id)sender;
- (IBAction)clickFacebook:(id)sender;
- (IBAction)clickTwitter:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *labelTitulo;

@end
