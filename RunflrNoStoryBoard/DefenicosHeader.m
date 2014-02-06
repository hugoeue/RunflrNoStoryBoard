//
//  Pesquise0.m
//  DinamicTable
//
//  Created by Hugo Costa on 31/01/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import "DefenicosHeader.h"

@interface DefenicosHeader ()

@end

@implementation DefenicosHeader

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)RotateArrow:(BOOL)value
{
    [UIView animateWithDuration:0.5 animations:^{
    if (value) {
        [self.linha setAlpha:0];
        self.imageArrow.transform = CGAffineTransformMakeRotation(M_PI/2);
    }else
    {
        [self.linha setAlpha:1];
        self.imageArrow.transform = CGAffineTransformMakeRotation(0);
    }
    }];
    
}

@end
