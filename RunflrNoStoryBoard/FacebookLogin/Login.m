//
//  Login.m
//  RunflrNoStoryBoard
//
//  Created by Hugo Costa on 04/12/13.
//  Copyright (c) 2013 Hugo Costa. All rights reserved.
//

#import "Login.h"
#import "AppDelegate.h"
#import "UserParser.h"
#import "LoginRundlr.h"
#import "FormularioRegistoContaRundlr.h"
#import "WebServiceSender.h"
#import "DemoRootViewController.h"

@interface Login () <UINavigationBarDelegate>
{
    WebServiceSender * webservi;
    WebServiceSender * recuperarPass;
}

@end

@implementation Login

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)CarregarLingua
{
    self.labelTitulo.text = [Language textForIndex:@"Entre_titulo"];
    self.labelSubTitulo.text = [Language textForIndex:@"Entre_registar"];
    self.labelOu.text = [Language textForIndex:@"OU"];
    [self.buttonIniciar setTitle:[Language textForIndex:@"Iniciar_sessao"] forState:UIControlStateNormal];
    [self.buttonLogin setTitle:[Language textForIndex:@"Login_facebook"] forState:UIControlStateNormal];
    [self.buttonRegisto setTitle:[Language textForIndex:@"Registar_Menu_Guru"] forState:UIControlStateNormal];
    [self.buttonRecuperar setTitle:[Language textForIndex:@"Esqueceu_password"] forState:UIControlStateNormal];
    [self.textFieldemail setPlaceholder:[Language textForIndex:@"Email"]];
    [self.textFieldPassword setPlaceholder:[Language textForIndex:@"Password"]];
}

-(void)viewWillAppear:(BOOL)animated
{
    
    self.title = @"Login";
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 25, 25)];
    [button addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"b_back.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    //[anotherButton setImage:[UIImage imageNamed:@"b_back.png"]];
    
    
    self.navigationItem.leftBarButtonItem = anotherButton;
    
    
    CGRect frame = CGRectMake(0, 0, 100, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:frame] ;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:101.0/255.0 green:112.0/255.0 blue:122.0/255.0 alpha:1];
    label.text = @"Login";
    self.navigationItem.titleView = label;
    
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self CarregarLingua];
    
    [Utils mudaBarraParaSeIos7:UIStatusBarStyleDefault];
     //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    // Do any additional setup after loading the view from its nib.
//    if (![FBSession activeSession].isOpen) {
//        [self.buttonLogin setTitle:@"Login com facebook" forState:UIControlStateNormal];
//    }else
//    {
//        [self.buttonLogin setTitle:@"Logout" forState:UIControlStateNormal];
//    }
    
    //[self.navigationController setTitle:@"Login APT"];
    //self.navigationController.navigationBarHidden = NO;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singleTap];
    
    
    [UIView animateWithDuration:0.0 animations:^{
        self.navigationController.view.frame = CGRectMake(0.0, 0.0, 320.0, self.view.frame.size.height);
        self.navigationController.navigationBar.frame = CGRectMake(0.0, 0.0, 320.0, 64.0);
    }];
    
    
   
}

- (UIBarPosition)positionForBar:(id <UIBarPositioning>)bar
{
    return UIBarPositionTopAttached;
}

- (void)handleSingleTap:(UITapGestureRecognizer *)sender
{
    [self.textFieldPassword resignFirstResponder];
    [self.textFieldemail resignFirstResponder];
}


- (IBAction)popAnterior:(id)sender {
    [self close];
}

-(void)close
{
    //[self.navigationController popToRootViewControllerAnimated:NO];
   //[self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    //[[DemoRootViewController getInstance] chamarOutroTopo];
    
   

    
}

- (IBAction)clickLoginRundlr:(id)sender {
    LoginRundlr *login = [LoginRundlr new];
    [self.navigationController pushViewController:login animated:YES];
}

- (IBAction)clickRegistoRundlr:(id)sender {
    
    FormularioRegistoContaRundlr *form = [FormularioRegistoContaRundlr new];
    form.delegate = self;
    [self.navigationController pushViewController:form animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButton:(id)sender
{
    if (![FBSession activeSession].isOpen) {
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    if (appDelegate.session.state != FBSessionStateCreated) {
        // Create a new, logged out session.
        appDelegate.session = [[FBSession alloc] init];
        
    }
    [appDelegate.session openWithCompletionHandler:^(FBSession *session,
                                                     FBSessionState status,
                                                     NSError *error) {
        
        
        
        [FBSession setActiveSession:session];
        [[FBRequest requestForMe] startWithCompletionHandler:^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
            if (!error) {
                
                [NSThread detachNewThreadSelector:@selector(upUser:) toTarget:self withObject:user];
                
            }
        }];
        
       [self.buttonLogin setTitle:@"Logout" forState:UIControlStateNormal];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    }else{
        [self facebookLoginLogout];
        [self.buttonLogin setTitle:@"Login com facebook" forState:UIControlStateNormal];
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
}

- (void)upUser:(NSDictionary<FBGraphUser> *)user
{
    NSString *userId = user.id;
    NSString *userName = user.name;
    NSString *userEmail = [user objectForKey:@"email"];
    
    NSLog(@"USERID: %@", userId);
    NSLog(@"USER: %@", userName);
    NSLog(@"mail: %@", userEmail);
    
    if (![Globals user]) {
        [Globals setUser:[[User alloc] init]];
    }
    
   
             
             //             NSLog(@"USER DATA:::%@  -  %@", user.id, user.name);
             
             [Globals user].email = [user objectForKey:@"email"];
             
             [Globals user].faceId = user.id;
             [Globals user].name = user.name;
             [Globals user].loginType = @"facebook";
    
    
     [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
             


    
}


-(void)startUpContainers2
{
    NSLog(@"Consegui fazer o parser do user");
   // [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popToRootViewControllerAnimated:NO];
}

-(void)noConnect2
{
    NSLog(@"NAO consegui fazer o parser do user");
}



- (void)facebookLoginLogout
{
    if ([FBSession activeSession].isOpen) {
        [[FBSession activeSession] closeAndClearTokenInformation];
        [self.navigationController popToRootViewControllerAnimated:YES];
       
    } else {
       
    }
    
    
}


-(BOOL)shouldAutorotate
{
    return NO;
}

- (IBAction)clickSubmeter:(id)sender {
    
    webservi = [[WebServiceSender alloc] initWithUrl:@"http://80.172.235.34/~tecnoled/menuguru/rundlrweb/data/json_login_confirm.php" method:@"" tag:1];
    webservi.delegate = self;
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    
    if([self.textFieldemail.text length]== 0)
        self.textFieldemail.text = @"";
    if([self.textFieldPassword.text length]== 0)
        self.textFieldPassword.text = @"";
    
    [dict setObject:self.textFieldemail.text forKey:@"email"];
    [dict setObject:self.textFieldPassword.text forKey:@"password"];
    [dict setObject:[Globals lang] forKey:@"lang"];
    
    [webservi sendDict:dict];
    
}

- (IBAction)clickRecuperarPass:(id)sender {
   
    if(self.textFieldemail.text.length>0)
    {
        [self recuperarPass];
    }
    else
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Campo vazio" message:@"o campo do email deve estar preenchido para poder recuperar a password" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}

-(void)recuperarPass
{
    recuperarPass = [[WebServiceSender alloc] initWithUrl:@"http://80.172.235.34/~tecnoled/menuguru/rundlrweb/data/json_recuperar_pass.php" method:@"" tag:2];
    recuperarPass.delegate = self;
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:self.textFieldemail.text forKey:@"email"];
    [dict setObject:[Globals lang] forKey:@"lang"];
    
    [recuperarPass sendDict:dict];
}


-(void)sendCompleteWithResult:(NSDictionary*)result withError:(NSError*)error{
    
    
    if (!error)
    {
        int tag=[WebServiceSender getTagFromWebServiceSenderDict:result];
        switch (tag)
        {
            case 1:
            {
                NSLog(@"resultado da tania no Login =>%@", result.description);
                
                //resp = "Successfully inserted 1 row";
                
                if([[result objectForKey:@"resp"] isEqualToString:@"SUCESSO"]){
                     UIAlertView * alert = [[UIAlertView alloc] initWithTitle:[result objectForKey:@"titulo"] message:[result objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                    [alert show];
                    
                    
                    User *regUser = [User new];
                    regUser.dbId = [[result objectForKey:@"userid"] integerValue];
                    regUser.name = [result objectForKey:@"pnome"];
                    regUser.email = [result objectForKey:@"email"];
                    regUser.photo =[result objectForKey:@"imagem"];
                    regUser.loginType = @"guru";
                    
                    if([[result objectForKey:@"news"] isEqualToString:@"0"])
                    
                        regUser.isPublish = NO;
                    else
                        regUser.isPublish = YES;
                    
                    
                    [Globals setUser:regUser];
                    
                    NSDictionary * paraDefaults  = [[NSDictionary alloc] initWithDictionary:result];
                    
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    [defaults setObject:paraDefaults forKey:@"login"];
                    [defaults synchronize];
                    
                    [self dismissViewControllerAnimated:YES completion:nil];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }else{
                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:[result objectForKey:@"titulo"] message:[result objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                    [alert show];
                }
                
                
                
                break;
            }
            case 2:
            {
                NSLog(@"Resultado recuperar password %@",result.description);
                
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Recuperação de password" message:[result objectForKey:@"envio"] delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                [alert show];
                break;
            }
                
        }
    }else
    {
        NSLog(@"error tanita %@",error);
        
    }
    
    
}



@end
