//
//  Pesquise1.m
//  DinamicTable
//
//  Created by Hugo Costa on 31/01/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import "DefenicoesNormal.h"

@interface DefenicoesNormal ()

@end

@implementation DefenicoesNormal

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

//- (IBAction)seleciounouSelector:(id)sender {
//    
//    NSLog(@"index selecionado %@",[NSNumber numberWithInteger:self.selector.selectedSegmentIndex]);
//    
//    if(self.delegate)
//        [self.delegate performSelector:@selector(selecionado:) withObject:[NSNumber numberWithInteger:self.selector.selectedSegmentIndex]];
//    
//}
@end
