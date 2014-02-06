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
#import "MainPage.h"
#import "Defenicoes.h"
#import <FacebookSDK/FacebookSDK.h>

@interface MenuRefugio ()

@property (strong, nonatomic) NSCache *imageCache;

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
    self.labelInicio.text = [Language textForIndex:@"Inicio"];
    self.labelDfenicoes.text =[Language textForIndex:@"Definicoes"];
    self.labelLingua.text = [Language textForIndex:@"Idioma"];
    self.labelMinhaCont.text = [Language textForIndex:@"Minha_conta"];
    
    [self.view setUserInteractionEnabled:YES];
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
     [self.view setUserInteractionEnabled:NO];
    
    Login *c = [[Login alloc] init];
    [self.navigationController pushViewController:c animated:YES];
    PP_RELEASE(c);
}

- (IBAction)buttonLingua:(id)sender {
     [self.view setUserInteractionEnabled:NO];
//    LanguageViewController *linguas =[LanguageViewController new];
//    linguas.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    //[self.revealSideViewController presentViewController:linguas animated:YES completion:nil];
    
    //[self.delegate performSelector:@selector(chamarLigua) ];
    
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:[LanguageViewController new]];
    
       [self.revealSideViewController popViewControllerWithNewCenterController:nav animated:YES];
   
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    
    
    NSLog(@"Tipo de login realisado pagina pessoal %@",[Globals user].loginType);
    
    if([[Globals user].loginType isEqualToString:@"facebook"])
    {
        [self loadFaceImage];
    }
    else if([[Globals user].loginType isEqualToString:@"guru"])
    {
        [self loadGuruImage];
    }
    else if ([FBSession activeSession].isOpen && ![Globals user]){
        [self loadFaceImage];
    }
    else
    {
        //[self.buttonLogin setTitle:@"Login" forState:UIControlStateNormal];
        self.labelLogin.text = @"Login";
        [self.imgLogin setImage:[UIImage imageNamed:@"b_desligado.png"]];
    }
    
}

- (void)loadFaceImage
{
  
    self.labelLogin.text = [Language textForIndex:@"Conectado"];
     [self.imgLogin setImage:[UIImage imageNamed:@"b_ligado.png"]];
    
    NSString *str = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture", [Globals user].faceId];
    
    
    UIImage *image1 = [self.imageCache objectForKey:str];
    
    
    if (!image1) {
        NSData* data1 = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:str]];
        image1 = [UIImage imageWithData:data1];
        if (image1)
            [self.imageCache setObject:image1 forKey:str];
    }
    
    self.imgUser.image = image1;
    self.imgUser.layer.cornerRadius = self.imgUser.frame.size.height/2;
    self.imgUser.clipsToBounds = YES;
    self.imgUser.layer.borderWidth = 0.0f;
    self.imgUser.layer.borderColor = [UIColor blackColor].CGColor;
    
    //self.labelName.text =[NSString stringWithFormat:@"%@ %@",[Language textForIndex:@"Ola"],[Globals user].name] ;
    //self.labelName.font = [UIFont fontWithName:@"DKCrayonCrumble" size:22];
    
    self.labelOla.text =[Language textForIndex:@"Ola"];
    self.labelUserName.text = [Globals user].name ;
}

- (void)loadGuruImage
{
    //[self.buttonLogin setTitle:[Language textForIndex:@"Conectado"] forState:UIControlStateNormal];
    self.labelLogin.text = [Language textForIndex:@"Conectado"];
    [self.imgLogin setImage:[UIImage imageNamed:@"b_ligado.png"]];
    
    //self.imgUser.image = [UIImage imageNamed:@"transferir.jpeg"];
    
    
    //NSString * imagemDoUser = [NSString stringWithFormat:@"http://80.172.235.34/~tecnoled/menuguru/rundlrweb/data/%@",[Globals user].photo];
    
    
    
    NSString * baseImage = [Globals user].photo ;
    
    NSData* data = [[NSData alloc] initWithBase64Encoding:baseImage ];
    UIImage* image = [UIImage imageWithData:data];
    
    
    if(self.imgUser)
        [self.imgUser setImage:image];
    
    //[self.imgUser setImageWithContentsOfURL:[NSURL URLWithString:imagemDoUser]];
    self.imgUser.layer.cornerRadius = self.imgUser.frame.size.height/2;
    self.imgUser.clipsToBounds = YES;
    self.imgUser.layer.borderWidth = 0.0f;
    self.imgUser.layer.borderColor = [UIColor whiteColor].CGColor;
    //self.labelName.text =[NSString stringWithFormat:@"%@ %@",[Language textForIndex:@"Ola"],[Globals user].name] ;
    //self.labelName.font = [UIFont fontWithName:@"DKCrayonCrumble" size:22];
    
    self.labelOla.text =[Language textForIndex:@"Ola"];
    self.labelUserName.text = [Globals user].name ;
}




- (IBAction)buttonPaginaPessoal:(id)sender {
     [self.view setUserInteractionEnabled:NO];
    
    if([Globals user]){
//    
//        PaginaPessoal *pagPessoal = [PaginaPessoal new];
//        pagPessoal.delegate = self.delegate;
//        //[self.navigationController pushViewController:pagPessoal animated:YES];
//        pagPessoal.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//        [self presentViewController:pagPessoal animated:YES completion:nil];
        [self.revealSideViewController popViewControllerWithNewCenterController:[PaginaPessoal new] animated:YES];
    }else
    {
        Login *login =[Login new];
        login.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:login] animated:YES completion:nil];
    }
    
    //[self.delegate performSelector:@selector(chamarPaginaPessoal) ];
    
}

- (IBAction)clickMenu:(id)sender {
    [self.view setUserInteractionEnabled:NO];

    [self.delegate performSelector:@selector(chamarOutroTopo) ];
}



- (IBAction)clickInicio:(id)sender {
//     [self.view setUserInteractionEnabled:NO];
//    [self.delegate performSelector:@selector(chamarTopo) withObject:nil];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[MainPage new]];
     [self.revealSideViewController popViewControllerWithNewCenterController:nav animated:YES];
}

- (IBAction)clickDefenicoes:(id)sender {
//     [self.view setUserInteractionEnabled:NO];
//    [self.delegate performSelector:@selector(chamarDefenicoes) withObject:nil];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[Defenicoes new]];
    [self.revealSideViewController popViewControllerWithNewCenterController:nav animated:YES];

}


- (IBAction)clickLoginLogout:(id)sender {
    
    NSLog(@"Tipo de login realisado mainpage click fav%@",[Globals user].loginType);
    
    if([[Globals user].loginType isEqualToString:@"facebook"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[Language textForIndex:@"Logout_titulo"] message:[Language textForIndex:@"Logout_descricao"] delegate:self cancelButtonTitle:[Language textForIndex:@"Nao"] otherButtonTitles:[Language textForIndex:@"Sim"], nil];
        alert.tag = 1;
        [alert show];
    }
    else if([[Globals user].loginType isEqualToString:@"guru"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[Language textForIndex:@"Logout_titulo"] message:[Language textForIndex:@"Logout_descricao"] delegate:self cancelButtonTitle:[Language textForIndex:@"Nao"] otherButtonTitles:[Language textForIndex:@"Sim"], nil];
        alert.tag = 1;
        [alert show];
    }
    else if (![Globals user]){
        Login *login =[Login new];
        login.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:login] animated:YES completion:nil];
    }else{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[Language textForIndex:@"Logout_titulo"] message:[Language textForIndex:@"Logout_descricao"] delegate:self cancelButtonTitle:[Language textForIndex:@"Nao"] otherButtonTitles:[Language textForIndex:@"Sim"], nil];
        alert.tag = 1;
        [alert show];
        
    }

    
    
    
    
    
    
    
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag ==1) {
        
        if(buttonIndex == 0)//nao
        {
            //do something
        }
        else if(buttonIndex == 1)//sim
        {
            [self loginLogou];
        }
    }
}

-(void)loginLogou
{
    
    [[FBSession activeSession] closeAndClearTokenInformation];
    
    [self limparRegistosDefaults];
    [self.imgLogin setImage:[UIImage imageNamed:@"b_desligado.png"]];
    [self.imgUser setImage:[UIImage imageNamed:@"LogoGuru.png"]];
    [self.labelUserName setText:@"Faz Login APT"];
   
    
}

-(void)limparRegistosDefaults
{
    
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    NSUserDefaults *defauts = [NSUserDefaults standardUserDefaults];
    [defauts removePersistentDomainForName:appDomain];
    [defauts synchronize];
    [self.labelLogin setText:@"Login" ];
    [Globals setUser:nil];
  
#warning  tenho de trocar cenas aqui
    // tenho de trocar a imagem por defeito assim como os texto a aparecer
}

@end
