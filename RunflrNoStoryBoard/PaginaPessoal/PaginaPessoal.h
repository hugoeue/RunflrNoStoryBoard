//
//  PaginaPessoal.h
//  RunflrNoStoryBoard
//
//  Created by Hugo Costa on 16/12/13.
//  Copyright (c) 2013 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaginaPessoal : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imgUser;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
- (IBAction)clickLoginLogout:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *buttonLogin;

- (IBAction)clickBack:(id)sender;

@property (nonatomic , assign) id delegate;

@end
