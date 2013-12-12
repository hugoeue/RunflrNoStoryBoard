//
//  LanguageViewController.m
//  RunflrNoStoryBoard
//
//  Created by Hugo Costa on 07/12/13.
//  Copyright (c) 2013 Hugo Costa. All rights reserved.
//

#import "LanguageViewController.h"

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
	// Do any additional setup after loading the view.
    [self setSelectedLanguageImage];

}

-(void)setSelectedLanguageImage
{
    if (![[Globals lang] isEqualToString:@"pt"]) {
        [self.imgPT setImage:[UIImage imageNamed:@"noselect.png"]];
    }
    if (![[Globals lang] isEqualToString:@"en"]) {
        [self.imgEN setImage:[UIImage imageNamed:@"noselect.png"]];
    }
    if (![[Globals lang] isEqualToString:@"fr"]) {
        [self.imgFR setImage:[UIImage imageNamed:@"noselect.png"]];
    }
    if (![[Globals lang] isEqualToString:@"es"]) {
        [self.imgES setImage:[UIImage imageNamed:@"noselect.png"]];
    }
    if (![[Globals lang] isEqualToString:@"de"]) {
        [self.imgDE setImage:[UIImage imageNamed:@"noselect.png"]];
    }
    if (![[Globals lang] isEqualToString:@"it"]) {
        [self.imgIT setImage:[UIImage imageNamed:@"noselect.png"]];
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
    [self dismissViewControllerAnimated:YES completion:nil];
    //[self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)ptClick:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"pt" forKey:@"language"];
    [defaults synchronize];
    
    [Globals setLang:@"pt"];
    [self dismissViewControllerAnimated:YES completion:nil];
    //[self dismissModalViewControllerAnimated:YES];
}

- (IBAction)deClick:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"de" forKey:@"language"];
    [defaults synchronize];
    
    [Globals setLang:@"de"];
    [self dismissViewControllerAnimated:YES completion:nil];
    //[self dismissModalViewControllerAnimated:YES];
}

- (IBAction)itClick:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"it" forKey:@"language"];
    [defaults synchronize];
    
    [Globals setLang:@"it"];
    [self dismissViewControllerAnimated:YES completion:nil];
    //[self dismissModalViewControllerAnimated:YES];
}

- (IBAction)enClick:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"en" forKey:@"language"];
    [defaults synchronize];
    
    [Globals setLang:@"en"];
    [self dismissViewControllerAnimated:YES completion:nil];
    //[self dismissModalViewControllerAnimated:YES];
}



- (IBAction)esClick:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"es" forKey:@"language"];
    [defaults synchronize];
    
    [Globals setLang:@"es"];
    [self dismissViewControllerAnimated:YES completion:nil];
    //[self dismissModalViewControllerAnimated:YES];
}



- (IBAction)frClick:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"fr" forKey:@"language"];
    [defaults synchronize];
    
    [Globals setLang:@"fr"];
    [self dismissViewControllerAnimated:YES completion:nil];
    //[self dismissModalViewControllerAnimated:YES];
}


- (void)viewDidUnload {
    [self setButtonClose:nil];
    [super viewDidUnload];
}


@end
