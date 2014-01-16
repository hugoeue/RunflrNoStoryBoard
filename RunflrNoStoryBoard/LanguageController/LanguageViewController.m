//
//  LanguageViewController.m
//  RunflrNoStoryBoard
//
//  Created by Hugo Costa on 07/12/13.
//  Copyright (c) 2013 Hugo Costa. All rights reserved.
//

#import "LanguageViewController.h"
#import "DemoRootViewController.h"

@interface LanguageViewController ()

@end

@implementation LanguageViewController

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
    [self escurecer:0];
    [self escurecer:0.5];
    
	// Do any additional setup after loading the view.
    [self setSelectedLanguageImage];
    // [self setFontFamily:@"DKCrayonCrumble" forView:self.view andSubViews:YES];
    self.scrollview.contentSize = CGSizeMake(320, 409);

}

-(void)escurecer:(float)time
{
    float alpha = 0.5;
    
    if (self.viewPretaGrande.alpha== alpha) {
        [UIView animateWithDuration:time animations:^{
            [self.viewPretaGrande setAlpha:0];
            
            [self.buttonMenu setFrame:CGRectMake(self.buttonMenu.frame.origin.x+3
                                                 ,self.buttonMenu.frame.origin.y+3
                                                 ,self.buttonMenu.frame.size.width-6
                                                 ,self.buttonMenu.frame.size.height-6
                                                 )];
        }];
        
    }else
    {
        [UIView animateWithDuration:time animations:^{
            [self.viewPretaGrande setAlpha:alpha];
            
            [self.buttonMenu setFrame:CGRectMake(self.buttonMenu.frame.origin.x-3
                                                 ,self.buttonMenu.frame.origin.y-3
                                                 ,self.buttonMenu.frame.size.width+6
                                                 ,self.buttonMenu.frame.size.height+6
                                                 )];
        }];
        
    }
}


-(void)setFontFamily:(NSString*)fontFamily forView:(UIView*)view andSubViews:(BOOL)isSubViews
{
    if ([view isKindOfClass:[UILabel class]])
    {
        UILabel *lbl = (UILabel *)view;
        [lbl setFont:[UIFont fontWithName:fontFamily size:[[lbl font] pointSize]]];
    }
    
    if (isSubViews)
    {
        for (UIView *sview in view.subviews)
        {
            [self setFontFamily:fontFamily forView:sview andSubViews:YES];
        }
    }
}


-(void)setSelectedLanguageImage
{
    if (![[Globals lang] isEqualToString:@"pt"]) {
        [self.imgPT setImage:[UIImage imageNamed:@"botao_no_select.png"]];
    }
    if (![[Globals lang] isEqualToString:@"en"]) {
        [self.imgEN setImage:[UIImage imageNamed:@"botao_no_select.png"]];
    }
    if (![[Globals lang] isEqualToString:@"fr"]) {
        [self.imgFR setImage:[UIImage imageNamed:@"botao_no_select.png"]];
    }
    if (![[Globals lang] isEqualToString:@"es"]) {
        [self.imgES setImage:[UIImage imageNamed:@"botao_no_select.png"]];
    }
    if (![[Globals lang] isEqualToString:@"de"]) {
        [self.imgDE setImage:[UIImage imageNamed:@"botao_no_select.png"]];
    }
    if (![[Globals lang] isEqualToString:@"it"]) {
        [self.imgIT setImage:[UIImage imageNamed:@"botao_no_select.png"]];
    }
    
    NSLog(@"lingua no globals %@", [Globals lang]);
    
}


- (void)startStoryBoardLang
{
    [self.buttonClose setTitle:[Language textForIndex:@"GlobalFechar"] forState:UIControlStateNormal];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeClick:(id)sender
{
    //[self dismissViewControllerAnimated:YES completion:nil];
    //[self.navigationController popToRootViewControllerAnimated:YES];
    
    [[DemoRootViewController getInstance] chamarOutroTopo];
    [self escurecer:0.5];

}

- (IBAction)ptClick:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"pt" forKey:@"language"];
    [defaults synchronize];
    
    [Globals setLang:@"pt"];
    [self dismissViewControllerAnimated:YES completion:nil];
    //[self dismissModalViewControllerAnimated:YES];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)deClick:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"de" forKey:@"language"];
    [defaults synchronize];
    
    [Globals setLang:@"de"];
    [self dismissViewControllerAnimated:YES completion:nil];
    //[self dismissModalViewControllerAnimated:YES];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)itClick:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"it" forKey:@"language"];
    [defaults synchronize];
    
    [Globals setLang:@"it"];
    [self dismissViewControllerAnimated:YES completion:nil];
    //[self dismissModalViewControllerAnimated:YES];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)enClick:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"en" forKey:@"language"];
    [defaults synchronize];
    
    [Globals setLang:@"en"];
    [self dismissViewControllerAnimated:YES completion:nil];
    //[self dismissModalViewControllerAnimated:YES];
    [self.navigationController popToRootViewControllerAnimated:YES];
}



- (IBAction)esClick:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"es" forKey:@"language"];
    [defaults synchronize];
    
    [Globals setLang:@"es"];
    [self dismissViewControllerAnimated:YES completion:nil];
    //[self dismissModalViewControllerAnimated:YES];
    [self.navigationController popToRootViewControllerAnimated:YES];
}



- (IBAction)frClick:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"fr" forKey:@"language"];
    [defaults synchronize];
    
    [Globals setLang:@"fr"];
    [self dismissViewControllerAnimated:YES completion:nil];
    //[self dismissModalViewControllerAnimated:YES];
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)viewDidUnload {
    [self setButtonClose:nil];
    [super viewDidUnload];
}


@end
