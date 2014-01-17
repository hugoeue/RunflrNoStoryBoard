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
#import "DemoRootViewController.h"

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
    [self escurecer:0.0];
    [self escurecer:0.5];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden = YES;
    
    self.labelDefeniçoes.text =[Language textForIndex:@"Definicoes"]; 
    self.labelPolitica.text =[Language textForIndex:@"Politica_privacidade"];
    self.labelSobre.text =[Language textForIndex:@"Sobre_Menu_Guru"];
    self.labelTermos.text =[Language textForIndex:@"Termos_condicoes"];
    self.labelFeedBack.text =[Language textForIndex:@"Feedback"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ClickAnterior:(id)sender {
    //[self.navigationController popToRootViewControllerAnimated:YES];
    
    [[DemoRootViewController getInstance] chamarOutroTopo];
    [self escurecer:0.5];
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



- (IBAction)clicksobreGuru:(id)sender {
    SobreMenuGuru * termos = [SobreMenuGuru new];
    termos.titulo = [Language textForIndex:@"Sobre_Menu_Guru"];
    
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
    termos.titulo = [Language textForIndex:@"Termos_condicoes"];

    
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
    termos.titulo = [Language textForIndex:@"Politica_privacidade"];
    
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
