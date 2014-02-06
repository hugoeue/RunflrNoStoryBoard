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



-(void)carregarLingua
{
    self.labelIdioma.text = [Language textForIndex:@"Idioma"];
    self.labelIngles.text = [Language textForIndex:@"Ingles"];
    self.labelFrances.text = [Language textForIndex:@"Frances"];
    self.labelEspanhol.text = [Language textForIndex:@"Espanhol"];
    self.labelAlemao.text = [Language textForIndex:@"Alemao"];
    self.labelItaliano.text = [Language textForIndex:@"Italiano"];
    self.labelPortugues.text = [Language textForIndex:@"Portugues"];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self escurecer:0];
    [self escurecer:0.5];
    
	// Do any additional setup after loading the view.
    [self setSelectedLanguageImage];
    // [self setFontFamily:@"DKCrayonCrumble" forView:self.view andSubViews:YES];
    self.scrollview.contentSize = CGSizeMake(320, 360);
    [self.scrollview setContentOffset:CGPointMake(0, 0)];
    [self carregarLingua];
    self.imagemTopo.image = [Globals getImagemGenerica];

    
    [Utils mudaBarraParaSeIos7:UIStatusBarStyleLightContent];
   // [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clarear)];
    [self.viewPretaGrande addGestureRecognizer:singleTap];
    
    CGRect frame = CGRectMake(0, 0, 100, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:frame] ;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:101.0/255.0 green:112.0/255.0 blue:122.0/255.0 alpha:1];
    label.text = [Language textForIndex:@"Idioma"];;
    self.navigationItem.titleView = label;
    
    self.navigationController.navigationBarHidden = NO;
    
    
    // para apenas o botao de voltar atras
    self.title = [Language textForIndex:@"Definicoes"];
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 25, 25)];
    [button addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"b_menu.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    //[anotherButton setImage:[UIImage imageNamed:@"b_back.png"]];
    
    
    self.navigationItem.leftBarButtonItem = anotherButton;

}


-(void)clarear
{
    [self escurecer:0.5];
}


-(void)resetBotoes
{

    [self.imgPT setImage:[UIImage imageNamed:@"paginarestaurante_0006_VISTO_CHECK"]];
    [self.imgDE setImage:[UIImage imageNamed:@"paginarestaurante_0006_VISTO_CHECK"]];
    [self.imgEN setImage:[UIImage imageNamed:@"paginarestaurante_0006_VISTO_CHECK"]];
    [self.imgES setImage:[UIImage imageNamed:@"paginarestaurante_0006_VISTO_CHECK"]];
    [self.imgFR setImage:[UIImage imageNamed:@"paginarestaurante_0006_VISTO_CHECK"]];
    [self.imgIT setImage:[UIImage imageNamed:@"paginarestaurante_0006_VISTO_CHECK"]];
    
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
        [self.imgPT setImage:[UIImage imageNamed:@"paginarestaurante_0005_VISTO_CHECK-2.png"]];
    }
    if (![[Globals lang] isEqualToString:@"en"]) {
        [self.imgEN setImage:[UIImage imageNamed:@"paginarestaurante_0005_VISTO_CHECK-2.png"]];
    }
    if (![[Globals lang] isEqualToString:@"fr"]) {
        [self.imgFR setImage:[UIImage imageNamed:@"paginarestaurante_0005_VISTO_CHECK-2.png"]];
    }
    if (![[Globals lang] isEqualToString:@"es"]) {
        [self.imgES setImage:[UIImage imageNamed:@"paginarestaurante_0005_VISTO_CHECK-2.png"]];
    }
    if (![[Globals lang] isEqualToString:@"de"]) {
        [self.imgDE setImage:[UIImage imageNamed:@"paginarestaurante_0005_VISTO_CHECK-2.png"]];
    }
    if (![[Globals lang] isEqualToString:@"it"]) {
        [self.imgIT setImage:[UIImage imageNamed:@"paginarestaurante_0005_VISTO_CHECK-2.png"]];
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
    
    //[[DemoRootViewController getInstance] chamarOutroTopo];

    [self escurecer:0.5];
    [self.revealSideViewController pushOldViewControllerOnDirection:PPRevealSideDirectionLeft animated:YES];
    

}

- (IBAction)ptClick:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"pt" forKey:@"language"];
    [defaults synchronize];
    
    [Globals setLang:@"pt"];
    //[self dismissViewControllerAnimated:YES completion:nil];
    //[self dismissModalViewControllerAnimated:YES];
    //[self.navigationController popToRootViewControllerAnimated:YES];
    //[[DemoRootViewController getInstance] chamarOutroTopo];
    //[self escurecer:0.5];
    [self resetBotoes];
    [self setSelectedLanguageImage];
}

- (IBAction)deClick:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"de" forKey:@"language"];
    [defaults synchronize];
    
    [Globals setLang:@"de"];
    //[self dismissViewControllerAnimated:YES completion:nil];
    //[self dismissModalViewControllerAnimated:YES];
    //[self.navigationController popToRootViewControllerAnimated:YES];
    //[[DemoRootViewController getInstance] chamarOutroTopo];
    //[self escurecer:0.5];
    [self resetBotoes];
    [self setSelectedLanguageImage];
}

- (IBAction)itClick:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"it" forKey:@"language"];
    [defaults synchronize];
    
    [Globals setLang:@"it"];
    //[self dismissViewControllerAnimated:YES completion:nil];
    //[self dismissModalViewControllerAnimated:YES];
    //[self.navigationController popToRootViewControllerAnimated:YES];
    //[[DemoRootViewController getInstance] chamarOutroTopo];
    //[self escurecer:0.5];
    [self resetBotoes];
    [self setSelectedLanguageImage];
}

- (IBAction)enClick:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"en" forKey:@"language"];
    [defaults synchronize];
    
    [Globals setLang:@"en"];
    //[self dismissViewControllerAnimated:YES completion:nil];
    //[self dismissModalViewControllerAnimated:YES];
    //[self.navigationController popToRootViewControllerAnimated:YES];
    //[[DemoRootViewController getInstance] chamarOutroTopo];
    //[self escurecer:0.5];
    [self resetBotoes];
    [self setSelectedLanguageImage];
}



- (IBAction)esClick:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"es" forKey:@"language"];
    [defaults synchronize];
    
    [Globals setLang:@"es"];
    //[self dismissViewControllerAnimated:YES completion:nil];
    //[self dismissModalViewControllerAnimated:YES];
    //[self.navigationController popToRootViewControllerAnimated:YES];
    //[[DemoRootViewController getInstance] chamarOutroTopo];
    //[self escurecer:0.5];
    [self resetBotoes];
    [self setSelectedLanguageImage];
}



- (IBAction)frClick:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"fr" forKey:@"language"];
    [defaults synchronize];
    
    [Globals setLang:@"fr"];
    //[self dismissViewControllerAnimated:YES completion:nil];
    //[self dismissModalViewControllerAnimated:YES];
    //[self.navigationController popToRootViewControllerAnimated:YES];
    //[[DemoRootViewController getInstance] chamarOutroTopo];
    //[self escurecer:0.5];
    [self resetBotoes];
    [self setSelectedLanguageImage];
}


- (void)viewDidUnload {
    [self setButtonClose:nil];
    [super viewDidUnload];
}


@end
