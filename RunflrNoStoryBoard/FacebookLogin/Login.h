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
@property (weak, nonatomic) IBOutlet UIButton *buttonLogin;
- (IBAction)popAnterior:(id)sender;

@end