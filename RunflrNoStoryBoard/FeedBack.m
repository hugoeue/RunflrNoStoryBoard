//
//  FeedBack.m
//  RunflrNoStoryBoard
//
//  Created by Hugo Costa on 29/12/13.
//  Copyright (c) 2013 Hugo Costa. All rights reserved.
//

#import "FeedBack.h"

@interface FeedBack ()

@end

@implementation FeedBack

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
- (IBAction)voltar:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
