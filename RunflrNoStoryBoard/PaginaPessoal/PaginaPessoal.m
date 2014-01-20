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
#import "Base64.h"
#import "Utils.h"
#import "DemoRootViewController.h"

@interface PaginaPessoal ()
{
    WebServiceSender * notif;
    WebServiceSender * juntarContas;
    WebServiceSender * newsLetter;
    WebServiceSender * enviarFoto;
    WebServiceSender * popUpWeb;
    
    NSString * fotobase;
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
    if (newsLetter)
        [newsLetter cancel];
    if (enviarFoto)
        [enviarFoto cancel];
    if (popUpWeb)
        [popUpWeb cancel];
    
    notif = nil;
    juntarContas = nil;
    newsLetter = nil;
    enviarFoto = nil;
    popUpWeb = nil;
}

-(void)carregarLingua
{
    self.labelConectar.text = [Language textForIndex:@"Conectar_Facebook"];
    self.labelNewsletter.text = [Language textForIndex:@"Receber_Newsletter"];
    self.labelMudarFoto.text = [Language textForIndex:@"Mudar_foto"];
    self.labelMinhaConta.text = [Language textForIndex:@"Minha_conta"];
    self.labelReceberNotificacoes.text = [Language textForIndex:@"Receber_Notificacoes"];
   
}

-(void)popUpWebservice:(NSString *)email
{
    if (popUpWeb) {
        [popUpWeb cancel];
    }
    popUpWeb = [[WebServiceSender alloc] initWithUrl:@"http://80.172.235.34/~tecnoled/menuguru/rundlrweb/data/json_add_newsletter_faceuser.php" method:@"" tag:5];
    popUpWeb.delegate = self;
    
    
    NSMutableDictionary * dict = [NSMutableDictionary new];
    [dict setObject:[Globals lang] forKey:@"lang"];
    [dict setObject:[Globals user].faceId forKey:@"face_id"];
    [dict setObject:email forKey:@"email"];
    
    [popUpWeb sendDict:dict];
    
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
                [self viewDidLoad];
                break;
            }
            case 3:
            {
                NSLog(@"resultado da newsLetter =>%@", result.description);
                
                // quando nao tem um email que funcione
                if([[result objectForKey:@"res"] isEqualToString:@"ERROFace"])
                {
                    
                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:[result objectForKey:@"titulo"] message:[result objectForKey:@"msgbox"] delegate:self cancelButtonTitle:[result objectForKey:@"botao"] otherButtonTitles:[result objectForKey:@"botaook"], nil];
                    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
                    alert.tag = 3;
                    [alert show];
                }
                
                else
                {
                    
                    if([[result objectForKey:@"res"] isEqualToString:@"eliminado com sucesso"])
                    {
                        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                        [defaults setObject:@"YES" forKey:@"newsletter"];
                        [self.botaoSelectNews setImage:[UIImage imageNamed:@"botao_no_select.png"]];
                        [Globals user].isPublish = NO;
                    }
                    
                    if([[result objectForKey:@"res"] isEqualToString:@"inserido com sucesso"])
                    {
                        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                        [self.botaoSelectNews setImage:[UIImage imageNamed:@"botao_select.png"]];
                        [defaults setObject:@"NO" forKey:@"newsletter"];
                        [Globals user].isPublish = YES;
                    }

                    
                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:[result objectForKey:@"titulo"] message:[result objectForKey:@"msgbox"] delegate:nil cancelButtonTitle:[result objectForKey:@"botaook"] otherButtonTitles:nil, nil];
                    
                    
                    [alert show];
                }
                
                
                break;
            }
            case 4:
            {
                NSLog(@"resultado do envio da foto para a tania =>%@", result.description);
                
                
                User *regUser = [User new];
                regUser.dbId = [Globals user].dbId ;
                regUser.name = [Globals user].name;
                regUser.email = [Globals user].name;
                regUser.photo =fotobase;
                regUser.loginType = @"guru";
                
                
                [Globals setUser:regUser];
               
                
                
               
                
                break;
            }
            case 5:
            {
                NSLog(@"resultado do envio do email para tania =>%@", result.description);
                
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:[result objectForKey:@"titulo"] message:[result objectForKey:@"msgbox"] delegate:nil cancelButtonTitle:[result objectForKey:@"botaook"] otherButtonTitles:nil, nil];
                
                
                [alert show];
                
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                
                if([[result objectForKey:@"res"] isEqualToString:@"sucesso"])
                {
                    [self.botaoSelectNews setImage:[UIImage imageNamed:@"botao_select.png"]];
                    [defaults setObject:@"NO" forKey:@"newsletter"];
                    [Globals user].isPublish = YES;
                }else
                {
                    [defaults setObject:@"YES" forKey:@"newsletter"];
                    [self.botaoSelectNews setImage:[UIImage imageNamed:@"botao_no_select.png"]];
                    [Globals user].isPublish = NO;

                }
                
                [defaults synchronize];


                
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
    
    [self carregarLingua];
    // Do any additional setup after loading the view from its nib.
    //self.navigationController.navigationBarHidden = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString* notifications = [defaults objectForKey:@"notifications"];
    NSString* newsletter = [defaults objectForKey:@"newsletter"];
    
    self.imagemTopo.image = [Globals getImagemGenerica];
    
   if([Globals user].faceId )
   {
       [self.butaoSelectJuntar setImage:[UIImage imageNamed:@"botao_select.png"]];
       [self.buttonJuntarContas setEnabled:NO];
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
    if([Globals user].isPublish)//{
        //if( [newsletter isEqualToString:@"YES"])
        {
            [self.botaoSelectNews setImage:[UIImage imageNamed:@"botao_select.png"]];
        }else
        {
            [self.botaoSelectNews setImage:[UIImage imageNamed:@"botao_no_select.png"]];
        }
    //}
    
    //[defaults synchronize];



}

-(void)viewWillAppear:(BOOL)animated
{
    
    [self escurecer:0];
    [self escurecer:0.5];
    
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
    [self.buttonLogin setTitle:[Language textForIndex:@"Conectado"] forState:UIControlStateNormal];
    
    
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
    self.imgUser.layer.borderWidth = 1.0f;
    self.imgUser.layer.borderColor = [UIColor whiteColor].CGColor;
    self.labelName.text =[NSString stringWithFormat:@"%@ %@",[Language textForIndex:@"Ola"],[Globals user].name] ;
    //self.labelName.font = [UIFont fontWithName:@"DKCrayonCrumble" size:22];
}

- (void)loadFaceImage
{
    [self.buttonSelecionarImagem setEnabled:NO];
    [self.buttonLogin setTitle:[Language textForIndex:@"Conectado"] forState:UIControlStateNormal];
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
   
    self.labelName.text =[NSString stringWithFormat:@"%@ %@",[Language textForIndex:@"Ola"],[Globals user].name] ;
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
//    [self dismissViewControllerAnimated:YES completion:^{
//        [self.delegate performSelector:@selector(callCenter)];
//    }];

    [self.navigationController popToRootViewControllerAnimated:NO];
    //[self.revealSideViewController pushOldViewControllerOnDirection:PPRevealSideDirectionNone animated:YES];
    
    [[DemoRootViewController getInstance] chamarOutroTopo];
}

- (IBAction)clickLoginLogout:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[Language textForIndex:@"Logout_titulo"] message:[Language textForIndex:@"Logout_descricao"] delegate:self cancelButtonTitle:[Language textForIndex:@"Nao"] otherButtonTitles:[Language textForIndex:@"Sim"], nil];
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
        
    }else if(alertView.tag ==2){
        
        
        if(buttonIndex == 0)//nao
        {
            //nao faz nada
        }
        else if(buttonIndex == 1)//galeria
        {
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:picker animated:YES completion:nil];
        }
        else if(buttonIndex == 2)//camera
        {
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:picker animated:YES completion:nil];
        }
    }else if(alertView.tag == 3)
    {
        if(buttonIndex == 0)//cancelar
        {
            //nao faz nada
        }
        else if(buttonIndex == 1)//galeria
        {
            // aqui tem de chamar outro webservice que manda o email
            //[alertView textFieldAtIndex:0] text];
            //NSLog(@"Entered: %@",[[alertView textFieldAtIndex:0] text]);
            
            [self popUpWebservice:[[alertView textFieldAtIndex:0] text]];
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


- (IBAction)clickBuscarImagem:(id)sender {
    picker = [[UIImagePickerController alloc] init];
    
    picker.delegate = self;

    [self mostarPopUpBuscarImagem];
}

-(void)mostarPopUpBuscarImagem
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:[Language textForIndex:@"Escolha_uma_foto"] message:@"" delegate:self cancelButtonTitle:[Language textForIndex:@"Cancel_imagem"] otherButtonTitles:[Language textForIndex:@"Galeria"],[Language textForIndex:@"Camera"], nil];
        alert.tag = 2;
        [alert show];
        
    } else
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Local?" message:@"" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"Galeria", nil];
        alert.tag = 2;
        [alert show];
        
    }

}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *) Picker {
    
    [Picker  dismissViewControllerAnimated:YES completion:nil];
    
   
    
}

- (void)imagePickerController:(UIImagePickerController *) Picker

didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    //NSLog(@"info da imagem %@", info);
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage * pickedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImageView * controller = [UIImageView new];
    controller.frame = CGRectMake(10, 10, 100, 100);
    //self.imgUser.image = pickedImage;
    //[self.view addSubview:controller];
    
    
    // codigo para encode da foto por clase
//    NSData* data = UIImageJPEGRepresentation(pickedImage, 1.0f);
//    [Base64 initialize];
//    NSString *strEncoded = [Base64 encode:data];
   
    
    // este codigo ja parece que funciona bem
   // NSLog(@"o resultado do encodetobase64 da foto escolhida %@", [self encodeToBase64String:pickedImage]);
    
    pickedImage = [Utils fixrotation:pickedImage];
    
    // tenho de calcular o tamanho ideal da imagem para poder fazer crop correctamente
    

    float novaLargura = 160;
    float altura =  pickedImage.size.height / (pickedImage.size.width / novaLargura);
    
    CGSize newSize = CGSizeMake(novaLargura , altura);
   
    
    pickedImage = [Utils imageWithImage:pickedImage scaledToSize:newSize];
    
    [self.imgUser setImage:pickedImage];
    
    [self EnviarFoto:[self encodeToBase64String:pickedImage]];
    
}

-(void)EnviarFoto:(NSString *)imageBase64
{
    if (!enviarFoto)
    enviarFoto = [[WebServiceSender alloc] initWithUrl:@"http://80.172.235.34/~tecnoled/menuguru/rundlrweb/data/json_foto_user.php" method:@"" tag:4];
    enviarFoto.delegate = self;
    
    NSString * userId =[NSString stringWithFormat:@"%d",[Globals user].dbId];
    
    NSMutableDictionary * dict = [NSMutableDictionary new];
    
    [dict setObject:imageBase64 forKey:@"img"];
    [dict setObject:userId forKey:@"user_id"];
    
    
    
   
    
    
    
    [enviarFoto sendDict:dict];
    
    
    // alem de gravar no globals tenho de gravar no resto dos sitios
    
    
    
       fotobase = imageBase64;
}


// codigo para upload das fotos

// codigo apenas existente para iOS7
- (NSString *)encodeToBase64String:(UIImage *)image
{
    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

//acaba aqui o codigo para upload das fotos


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

        }];
    }else{
        
        // quando faz logout
        [self facebookLoginLogout];

        
    }

}

- (IBAction)clickNewsLetter:(id)sender {
    newsLetter = [[WebServiceSender alloc] initWithUrl:@"http://80.172.235.34/~tecnoled/menuguru/rundlrweb/data/json_add_rem_news.php" method:@"" tag:3];
    newsLetter.delegate = self;
   
    NSString * publica;
    if([Globals user].isPublish)
        publica = @"0";
    else
        publica = @"1";
    
  
    
    
    
    
    NSMutableDictionary * dict = [NSMutableDictionary new];
    
    [dict setObject:publica forKey:@"favSend"];

    
    if([Globals user].faceId)
    {
     
        [dict setObject: [Globals user].faceId forKey:@"user_face"];
        [dict setObject: [NSString stringWithFormat:@"%d", 0] forKey:@"user_id"];
    }else
    {
        
        [dict setObject:[NSString stringWithFormat:@"%d", 0] forKey:@"user_face"];
        [dict setObject: [NSString stringWithFormat:@"%d", [Globals user].dbId] forKey:@"user_id"];
    }

    
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
    [Globals user].loginType = @"guru";
    
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
