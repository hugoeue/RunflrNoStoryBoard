//
//  Defenicoes.m
//  RunflrNoStoryBoard
//
//  Created by Hugo Costa on 25/12/13.
//  Copyright (c) 2013 Hugo Costa. All rights reserved.
//

#import "Defenicoes.h"
#import "SobreMenuGuru.h"
#import "FeedBack.h"

@interface Defenicoes ()

@end

@implementation Defenicoes

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ClickAnterior:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)clicksobreGuru:(id)sender {
    SobreMenuGuru * termos = [SobreMenuGuru new];
    termos.titulo = @"Sobre o menu guru";
    
    if ([[Globals lang] isEqualToString:@"pt"]) {
        NSLog(@"lingua em pt");
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Sobre nosPT" ofType:@"txt"];
        NSString *userAgreement = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
        termos.conteudo = userAgreement;
    }
    else{
        NSLog(@"lingua em %@", [Globals lang]);
        NSString *path = [[NSBundle mainBundle] pathForResource:@"About Us" ofType:@"txt"];
        NSString *userAgreement = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
        termos.conteudo = userAgreement;
        
    }

    
    
    [self.navigationController pushViewController:termos animated:YES];
}

- (IBAction)clickFeedBack:(id)sender {
    [self.navigationController pushViewController:[FeedBack new] animated:YES];
}
- (IBAction)clickTermos:(id)sender {
    SobreMenuGuru * termos = [SobreMenuGuru new];
    termos.titulo = @"Termos & condições";
    
    if ([[Globals lang] isEqualToString:@"pt"]) {
        NSLog(@"lingua em pt");
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Termos e condiçõesPT" ofType:@"txt"];
        NSString *userAgreement = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
        termos.conteudo = userAgreement;
    }
    else{
        NSLog(@"lingua em %@", [Globals lang]);
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Terms and Conditions" ofType:@"txt"];
        NSString *userAgreement = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
        termos.conteudo = userAgreement;
        
    }

    
     [self.navigationController pushViewController:termos animated:YES];
}

- (IBAction)clickPolitica:(id)sender {
    SobreMenuGuru * termos = [SobreMenuGuru new];
    termos.titulo = @"Política de privacidade";
    
    if ([[Globals lang] isEqualToString:@"pt"]) {
        NSLog(@"lingua em pt");
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Política de privacidadePT" ofType:@"txt"];
        NSString *userAgreement = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
        termos.conteudo = userAgreement;
    }
    else{
        NSLog(@"lingua em %@", [Globals lang]);
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Privacy Policy" ofType:@"txt"];
        NSString *userAgreement = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
        termos.conteudo = userAgreement;
        
    }

    
    [self.navigationController pushViewController:termos animated:YES];
}


@end
