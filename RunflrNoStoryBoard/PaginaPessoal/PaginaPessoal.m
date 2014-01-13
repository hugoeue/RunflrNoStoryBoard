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
#import "AppDelegate.h"
#import "WebServiceSender.h"

@interface PaginaPessoal ()
{
    WebServiceSender * notif;
    WebServiceSender * juntarContas;
    WebServiceSender * newsLetter;
}

@property (strong, nonatomic) NSCache *imageCache;

@end

@implementation PaginaPessoal

@synthesize picker;

-(void)dealloc
{
    if (notif) {
        [notif cancel];
    }
    if (juntarContas)
        [juntarContas cancel];
    
    notif = nil;
    juntarContas = nil;
}

-(void)receberNotifi:(NSString *)recebe
{
    notif = [[WebServiceSender alloc] initWithUrl:@"http://80.172.235.34/~tecnoled/menuguru/rundlrweb/data/json_add_rem_not.php" method:@"" tag:1];
    notif.delegate = self;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString * token = [defaults objectForKey:@"token"];
   
    
    
    
    
    NSMutableDictionary * dict = [NSMutableDictionary new];
    // validaçao apenas para o simulador... este nao suporta pushupnotifications
    if(token != nil)
        [dict setObject:token forKey:@"not"];
    else
        [dict setObject:@"token vindo do simulador" forKey:@"not"];
    
    if(recebe )
    {
        if ([recebe isEqualToString:@"YES"]) {
            [dict setObject:@"0" forKey:@"favSend"];
        }
        
        else
        {
            [dict setObject:@"1" forKey:@"favSend"];
        }
    }

    
    
    
    [notif sendDict:dict];
    
    
}

-(void)sendCompleteWithResult:(NSDictionary*)result withError:(NSError*)error{
    
    
    if (!error)
    {
        int tag=[WebServiceSender getTagFromWebServiceSenderDict:result];
        switch (tag)
        {
            case 1:
            {
                NSLog(@"resultado do envio do token =>%@", result.description);
                
                break;
            }
            case 2:
            {
                NSLog(@"resultado do juntar contas =>%@", result.description);
                
                if([[result objectForKey:@"resesc"] isEqualToString:@"Finalizado"])
                {
                    [self.butaoSelectJuntar setImage:[UIImage imageNamed:@"botao_select.png"]];
                }else
                {
                    [self.butaoSelectJuntar setImage:[UIImage imageNamed:@"botao_no_select.png"]];
                }
                [Globals user].faceId = nil;
                 [Globals user].loginType = @"guru";
                break;
            }
            case 3:
            {
                NSLog(@"resultado da newsLetter =>%@", result.description);
                
                break;
            }
                
                
        }
    }else
    {
        NSLog(@"error webserviceSender %@",error);
        
    }
    
    
}


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
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString* notifications = [defaults objectForKey:@"notifications"];
    NSString* newsletter = [defaults objectForKey:@"newsletter"];
    
    
   if([Globals user].faceId )
   {
       [self.butaoSelectJuntar setImage:[UIImage imageNamed:@"botao_select.png"]];
   }

    
    
    if(notifications )
    {
        if ([notifications isEqualToString:@"YES"]) {
            [self.botaoSelectNoti setImage:[UIImage imageNamed:@"botao_select.png"]];
        }
        
        else
        {
            [self.botaoSelectNoti setImage:[UIImage imageNamed:@"botao_no_select.png"]];
        }
    }
    if(newsletter){
        if( [newsletter isEqualToString:@"YES"])
        {
            [self.botaoSelectNews setImage:[UIImage imageNamed:@"botao_select.png"]];
        }else
        {
            [self.botaoSelectNews setImage:[UIImage imageNamed:@"botao_no_select.png"]];
        }
    }
    
    //[defaults synchronize];



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
    [self.buttonLogin setTitle:@"Conectado" forState:UIControlStateNormal];
    self.imgUser.image = [UIImage imageNamed:@"transferir.jpeg"];
    self.imgUser.layer.cornerRadius = self.imgUser.frame.size.height/2;
    self.imgUser.clipsToBounds = YES;
    self.imgUser.layer.borderWidth = 1.0f;
    self.imgUser.layer.borderColor = [UIColor whiteColor].CGColor;
    self.labelName.text =[NSString stringWithFormat:@"Olá %@",[Globals user].name] ;
    //self.labelName.font = [UIFont fontWithName:@"DKCrayonCrumble" size:22];
}

- (void)loadFaceImage
{
    
    [self.buttonLogin setTitle:@"Conectado" forState:UIControlStateNormal];
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
    self.imgUser.layer.borderColor = [UIColor blackColor].CGColor;
   
    self.labelName.text =[NSString stringWithFormat:@"Olá %@",[Globals user].name] ;
    //self.labelName.font = [UIFont fontWithName:@"DKCrayonCrumble" size:22];
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

    [self.navigationController popToRootViewControllerAnimated:YES];
    //[self.revealSideViewController pushOldViewControllerOnDirection:PPRevealSideDirectionNone animated:YES];
}

- (IBAction)clickLoginLogout:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Aviso" message:@"deseja desconectar?" delegate:self cancelButtonTitle:@"nao" otherButtonTitles:@"sim", nil];
    alert.tag = 1;
    [alert show];
    
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
    

}


- (IBAction)clickBack:(id)sender {
    //[self dismissViewControllerAnimated:YES completion:nil];
     [self.navigationController popToRootViewControllerAnimated:YES];
}



- (IBAction)clickReceberNotifacoes:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    

     NSString* notifications = [defaults objectForKey:@"notifications"];
    if(notifications && [notifications isEqualToString:@"YES"])
    {
        // muda a imagem do boneco
        // muda os defaults para outra cena
        [defaults setObject:@"NO" forKey:@"notifications"];
        [self.botaoSelectNoti setImage:[UIImage imageNamed:@"botao_no_select.png"]];
         [self receberNotifi:notifications];
    }else
    {
        [defaults setObject:@"YES" forKey:@"notifications"];
        [self.botaoSelectNoti setImage:[UIImage imageNamed:@"botao_select.png"]];
         [self receberNotifi:notifications];
    }
   
   
    [defaults synchronize];
}

- (IBAction)clickReceberNewsletter:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString* newsletter = [defaults objectForKey:@"newsletter"];
    if(newsletter && [newsletter isEqualToString:@"YES"])
    {
        // muda a imagem do boneco
        // muda os defaults para outra cena
        [defaults setObject:@"NO" forKey:@"newsletter"];
        [self.botaoSelectNews setImage:[UIImage imageNamed:@"botao_no_select.png"]];
    }else{
        //botao_no_select
        [defaults setObject:@"YES" forKey:@"newsletter"];
        [self.botaoSelectNews setImage:[UIImage imageNamed:@"botao_select.png"]];
    }
    [defaults synchronize];

}
- (IBAction)clickBuscarImagem:(id)sender {
    picker = [[UIImagePickerController alloc] init];
    
    picker.delegate = self;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        
    {
        
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
    } else
    
    {
        
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
    }
    
    [self presentViewController:picker animated:YES completion:nil];

    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *) Picker {
    
    [Picker  dismissViewControllerAnimated:YES completion:nil];
    
   
    
}

- (void)imagePickerController:(UIImagePickerController *) Picker

didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage * pickedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImageView * controller = [UIImageView new];
    controller.frame = CGRectMake(10, 10, 100, 100);
    self.imgUser.image = pickedImage;
    //[self.view addSubview:controller];
    
}




- (IBAction)clickJuntarContas:(id)sender {
    
    [self facebookLoginLogout];
    
    if (![FBSession activeSession].isOpen) {
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        
        if (appDelegate.session.state != FBSessionStateCreated) {
            // Create a new, logged out session.
            // quando acaba de fazer lgogin
            appDelegate.session = [[FBSession alloc] init];
            
        }
        [appDelegate.session openWithCompletionHandler:^(FBSession *session,
                                                         FBSessionState status,
                                                         NSError *error) {
            
            
            
            [FBSession setActiveSession:session];
            [[FBRequest requestForMe] startWithCompletionHandler:^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
                if (!error) {
                    
                    //[NSThread detachNewThreadSelector:@selector(upUser:) toTarget:self withObject:user];
                    [self upUser:user];
                }
            }];
            
            [self.buttonLogin setTitle:@"Logout" forState:UIControlStateNormal];
           // [self.navigationController popToRootViewControllerAnimated:YES];
        }];
    }else{
        
        // quando faz logout
        [self facebookLoginLogout];
//        [self.buttonLogin setTitle:@"Login" forState:UIControlStateNormal];
//        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }

}

- (IBAction)clickNewsLetter:(id)sender {
    newsLetter = [[WebServiceSender alloc] initWithUrl:@"http://80.172.235.34/~tecnoled/menuguru/rundlrweb/data/json_add_rem_news.php" method:@"" tag:3];
    newsLetter.delegate = self;
   
    
    NSMutableDictionary * dict = [NSMutableDictionary new];
    [dict setObject:[Globals user].email forKey:@"email"];
    [dict setObject:@"1" forKey:@"favSend"];
    
    
    
    [newsLetter sendDict:dict];
}


- (void)facebookLoginLogout
{
    if ([FBSession activeSession].isOpen) {
        [[FBSession activeSession] closeAndClearTokenInformation];
       // [self.navigationController popToRootViewControllerAnimated:YES];
        
    } else {
        
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
    NSLog(@"birtday: %@", user.birthday);
    
    if (![Globals user]) {
        [Globals setUser:[[User alloc] init]];
    }
    
    
    
    //             NSLog(@"USER DATA:::%@  -  %@", user.id, user.name);
    
    [Globals user].email = [user objectForKey:@"email"];
    
    [Globals user].faceId = user.id;
    [Globals user].name = user.name;
    [Globals user].loginType = @"facebook";
    
    //[self showFaceStuff];
    //[self loadUser];
    //[self loadFaceImage];
    
    
        
    juntarContas = [[WebServiceSender alloc] initWithUrl:@"http://80.172.235.34/~tecnoled/menuguru/rundlrweb/data/json_juntar_contas.php" method:@"" tag:2];
    juntarContas.delegate = self;
    
 
    
    
    NSString * userID = [NSString stringWithFormat:@"%d",[Globals user].dbId];
    
    
    NSMutableDictionary * dict = [NSMutableDictionary new];
   
    [dict setObject:[Globals user].faceId forKey:@"face_id"];
    [dict setObject:userID forKey:@"user_id"];
    
    
    
    
    [juntarContas sendDict:dict];

    
}

@end
