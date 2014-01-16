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
#import "PaginaPessoal.h"
#import "PaperFoldView.h"

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
    
    //[self changeFont:self.view];
}

-(void)carregarLingua
{
    self.labelDfenicoes.text =[Language textForIndex:@"Definicoes"];
    self.labelLingua.text = [Language textForIndex:@"Idioma"];
    self.labelMinhaCont.text = [Language textForIndex:@"A_minha_conta"];
}

-(void)viewDidAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    
    [self carregarLingua];
    
    
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
//    LanguageViewController *linguas =[LanguageViewController new];
//    linguas.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    //[self.revealSideViewController presentViewController:linguas animated:YES completion:nil];
    
    [self.delegate performSelector:@selector(chamarLigua) ];
    
}

- (IBAction)buttonPaginaPessoal:(id)sender {
    
//    if([Globals user]){
//    
//        PaginaPessoal *pagPessoal = [PaginaPessoal new];
//        pagPessoal.delegate = self.delegate;
//        //[self.navigationController pushViewController:pagPessoal animated:YES];
//        pagPessoal.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//        [self presentViewController:pagPessoal animated:YES completion:nil];
//    }else
//    {
//        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:[Login new]] animated:YES completion:nil];
//    }
    
    [self.delegate performSelector:@selector(chamarPaginaPessoal) ];
    
}

- (IBAction)clickMenu:(id)sender {
    [self.delegate performSelector:@selector(chamarOutroTopo) ];
}



- (IBAction)clickInicio:(id)sender {
    [self.delegate performSelector:@selector(chamarTopo) withObject:nil];
}

- (IBAction)clickDefenicoes:(id)sender {
    [self.delegate performSelector:@selector(chamarDefenicoes) withObject:nil];
}
@end
