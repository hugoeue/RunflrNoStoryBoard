//
//  NovoLogin.m
//  RunflrNoStoryBoard
//
//  Created by Hugo Costa on 12/12/13.
//  Copyright (c) 2013 Hugo Costa. All rights reserved.
//

#import "LoginRundlr.h"
#import "WebServiceSender.h"

@interface LoginRundlr ()
{
    WebServiceSender * webservi;
}

@end

@implementation LoginRundlr

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
    
    self.textFieldPassword.secureTextEntry = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
                }else{
                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Erro" message:@"Login errado" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
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
