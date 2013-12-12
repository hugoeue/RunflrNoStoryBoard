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
@property (weak, nonatomic) IBOutlet UILabel *labelLingua;

@end
