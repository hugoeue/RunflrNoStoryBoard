//
//  PaginaPessoal.m
//  RunflrNoStoryBoard
//
//  Created by Hugo Costa on 16/12/13.
//  Copyright (c) 2013 Hugo Costa. All rights reserved.
//

#import "PaginaPessoal.h"
#import <FacebookSDK/FacebookSDK.h>
#import "Login.h"

@interface PaginaPessoal ()

@property (strong, nonatomic) NSCache *imageCache;

@end

@implementation PaginaPessoal

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
    //self.navigationController.navigationBarHidden = NO;
    
    
    
    
    // como exemplo
    /*
    if (![FBSession activeSession].isOpen) {
        [self.buttonLogin setTitle:@"Login" forState:UIControlStateNormal];
    }else
    {
        [self.buttonLogin setTitle:@"Logout" forState:UIControlStateNormal];
    }
     */


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
        [self.buttonLogin setTitle:@"Login" forState:UIControlStateNormal];
    }

}

- (void)loadGuruImage
{
    [self.buttonLogin setTitle:@"Logout" forState:UIControlStateNormal];
    self.imgUser.image = [UIImage imageNamed:@"transferir.jpeg"];
    self.imgUser.layer.cornerRadius = self.imgUser.frame.size.height/2;
    self.imgUser.clipsToBounds = YES;
    self.imgUser.layer.borderWidth = 1.0f;
    self.imgUser.layer.borderColor = [UIColor whiteColor].CGColor;
    self.labelName.text =[NSString stringWithFormat:@"Olá %@",[Globals user].name] ;
    self.labelName.font = [UIFont fontWithName:@"DKCrayonCrumble" size:22];
}

- (void)loadFaceImage
{
    
    [self.buttonLogin setTitle:@"Logout" forState:UIControlStateNormal];
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
    self.imgUser.layer.borderWidth = 1.0f;
    self.imgUser.layer.borderColor = [UIColor whiteColor].CGColor;
   
    self.labelName.text =[NSString stringWithFormat:@"Olá %@",[Globals user].name] ;
    self.labelName.font = [UIFont fontWithName:@"DKCrayonCrumble" size:22];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)limparRegistosDefaults
{

    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    NSUserDefaults *defauts = [NSUserDefaults standardUserDefaults];
    [defauts removePersistentDomainForName:appDomain];
    [defauts synchronize];
    [self.buttonLogin setTitle:@"Login" forState:UIControlStateNormal];
    [Globals setUser:nil];
    [self dismissViewControllerAnimated:YES completion:^{
        [self.delegate performSelector:@selector(callCenter)];
    }];

    
    //[self.revealSideViewController pushOldViewControllerOnDirection:PPRevealSideDirectionNone animated:YES];
}

- (IBAction)clickLoginLogout:(id)sender {
    
    if([[Globals user].loginType isEqualToString:@"facebook"])
    {
         [[FBSession activeSession] closeAndClearTokenInformation];
        [self limparRegistosDefaults];
    }
    else if([[Globals user].loginType isEqualToString:@"guru"])
    {
        [self limparRegistosDefaults];
    }
    else if ([FBSession activeSession].isOpen && ![Globals user]){
         [[FBSession activeSession] closeAndClearTokenInformation];
        
        [self limparRegistosDefaults];
    }
//    else
//    {
//        // se nao entrar em nenhuma das condeiçoes anteriores tem de abrir o cenas de login
//        
//            Login *log = [Login new];
//        
//        
//            [self presentViewController:[[UINavigationController alloc] initWithRootViewController:log] animated:YES completion:nil];
//        
//    }

    
}


- (IBAction)clickBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end