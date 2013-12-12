//
//  MenuRefugio.m
//  RunflrNoStoryBoard
//
//  Created by Hugo Costa on 03/12/13.
//  Copyright (c) 2013 Hugo Costa. All rights reserved.
//

#import "MenuRefugio.h"
#import "Login.h"
#import "LanguageViewController.h"

@interface MenuRefugio ()

@end

@implementation MenuRefugio

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden = YES;
    [self changeFont:self.view];
}


-(void)changeFont:(UIView *) view{
    for (id View in [view subviews]) {
        if ([View isKindOfClass:[UILabel class]]) {
            [View setFont:[UIFont fontWithName:@"DKCrayonCrumble" size:32]];
            //view.textColor = [UIColor blueColor];
            [View setBackgroundColor:[UIColor clearColor]];
        }
        if ([View isKindOfClass:[UIView class]]) {
            [self changeFont:View];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonFacebookLogin:(id)sender {
    
    Login *c = [[Login alloc] init];
    [self.navigationController pushViewController:c animated:YES];
    PP_RELEASE(c);
}

- (IBAction)buttonLingua:(id)sender {
    LanguageViewController *linguas =[LanguageViewController new];
    [self.revealSideViewController presentViewController:linguas animated:YES completion:nil];
}
@end
