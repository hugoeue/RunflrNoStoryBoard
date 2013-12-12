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

@interface Login ()

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
}

- (IBAction)popAnterior:(id)sender {
    //[self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
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
    }];
    }else{
        [self facebookLoginLogout];
        [self.buttonLogin setTitle:@"Login" forState:UIControlStateNormal];
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
    
    
     [self dismissViewControllerAnimated:NO completion:nil];
             
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
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)noConnect2
{
    NSLog(@"NAO consegui fazer o parser do user");
}



- (void)facebookLoginLogout
{
    if ([FBSession activeSession].isOpen) {
        [[FBSession activeSession] closeAndClearTokenInformation];
       
    } else {
       
    }
    
    
}


@end
