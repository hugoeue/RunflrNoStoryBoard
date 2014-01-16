//
//  AnimationController.m
//  RunflrNoStoryBoard
//
//  Created by Hugo Costa on 14/01/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import "AnimationController.h"

@interface AnimationController ()

@end

@implementation AnimationController

@synthesize buttonAnimated;


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
   
    
    NSMutableArray * arrayImagens = [NSMutableArray new];
    [buttonAnimated setImage:[UIImage imageNamed:@"campanula00000.png"] forState:UIControlStateNormal];
    
    for (int i = 0 ; i<= 59; i++) {
        if(i<10)
            [arrayImagens addObject:[UIImage imageNamed:[NSString stringWithFormat:@"campanula0000%d.png",i]]];
        else
            [arrayImagens addObject:[UIImage imageNamed:[NSString stringWithFormat:@"campanula000%d.png",i]]];
    }
    
    
    buttonAnimated.imageView.animationImages = arrayImagens;
    
    buttonAnimated.imageView.animationDuration = 0.5;
    [buttonAnimated.imageView startAnimating];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
