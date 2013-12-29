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

@interface Login (){
     WebServiceSender * webservi;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (![FBSession activeSession].isOpen) {
        [self.buttonLogin setTitle:@"Login" forState:UIControlStateNormal];
    }else
    {
        [self.buttonLogin setTitle:@"Logout" forState:UIControlStateNormal];
    }
    self.navigationController.navigationBarHidden = YES;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singleTap];
}

- (void)handleSingleTap:(UITapGestureRecognizer *)sender
{
    [self.textFieldPassword resignFirstResponder];
    [self.textFieldemail resignFirstResponder];
}


- (IBAction)popAnterior:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    //[self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)clickLoginRundlr:(id)sender {
    
    
    LoginRundlr *login = [LoginRundlr new];
    [self.navigationController pushViewController:login animated:YES];
}

- (IBAction)clickRegistoRundlr:(id)sender {
    
    FormularioRegistoContaRundlr *form = [FormularioRegistoContaRundlr new];
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
        [self.buttonLogin setTitle:@"Login" forState:UIControlStateNormal];
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
    
    
     [self dismissViewControllerAnimated:NO completion:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
             
//    UserParser *userParser = [[UserParser alloc] initXMLParser];
//    
//    NSString *host = nil;
//    
//    //if (self.isOther) {
//    //  host = [NSString stringWithFormat:@"http://cms.citychef.pt/data/xml_user.php?is_me=0&user_id=%d&face_id=%@", self.otherUserDbId, self.otherUserFaceId];
//    //} else {
//    host = [NSString stringWithFormat:@"http://80.172.235.34/~tecnoled/menuguru/rundlrweb/data/xml_user.php?is_me=1&user_id=%d&face_id=%@", [Globals user].dbId, [Globals user].faceId];
//    //}
//    NSLog(@"host: %@", host);
//    
//    NSURL *url = [[NSURL alloc] initWithString: host];
//    NSXMLParser *nsXmlParser = [[NSXMLParser alloc] initWithContentsOfURL: url];
//    [nsXmlParser setDelegate:userParser];
//    
//    BOOL success = [nsXmlParser parse];
//    
//    
//    if (success) {
//        [self performSelectorOnMainThread:@selector(startUpContainers2) withObject:nil waitUntilDone:NO];
//        
//    } else {
//        [self performSelectorOnMainThread:@selector(noConnect2) withObject:nil waitUntilDone:NO];
//        
//    }

    
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


- (IBAction)clickSubmeter:(id)sender {
    
    webservi = [[WebServiceSender alloc] initWithUrl:@"http://80.172.235.34/~tecnoled/menuguru/rundlrweb/data/json_login_confirm.php" method:@"" tag:1];
    webservi.delegate = self;
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:self.textFieldemail.text forKey:@"email"];
    [dict setObject:self.textFieldPassword.text forKey:@"password"];
    
    [webservi sendDict:dict];
    
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
                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Sucesso" message:@"Login realizado com sucesso" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                    [alert show];
                    
                    
                    User *regUser = [User new];
                    regUser.dbId = [[result objectForKey:@"userid"] integerValue];
                    regUser.name = [result objectForKey:@"pnome"];
                    regUser.email = [result objectForKey:@"email"];
                    regUser.loginType = @"guru";
                    
                    
                    [Globals setUser:regUser];
                    
                    NSDictionary * paraDefaults  = [[NSDictionary alloc] initWithDictionary:result];
                    
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    [defaults setObject:paraDefaults forKey:@"login"];
                    [defaults synchronize];
                    
                    [self dismissViewControllerAnimated:YES completion:nil];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }else{
                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Erro" message:[result objectForKey:@"resp"] delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                    [alert show];
                }
                
                
                
                break;
            }
                
        }
    }else
    {
        NSLog(@"error paulo %@",error);
        
    }
    
    
}



@end
