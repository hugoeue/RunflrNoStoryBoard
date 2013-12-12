//
//  MainPage.m
//  RunflrNoStoryBoard
//
//  Created by Hugo Costa on 02/12/13.
//  Copyright (c) 2013 Hugo Costa. All rights reserved.
//

#import "MainPage.h"
#import "Resultados.h"
#import "MenuRefugio.h"
#import "CitiesParser.h"
#import "FeaturedParser.h"
#import "City.h"
#import <FacebookSDK/FacebookSDK.h>
#import "HTAutocompleteManager.h"
#import "AppDelegate.h"
#import "UserParser.h"


@interface MainPage ()
{
    
    
    NSString * tipo;
    
    BOOL isTiming;
    
    NSTimer *timer;
    
    UIAlertView *alert;
    UIAlertView *alertBoo;
    UIAlertView *alertBoo2;
}

@property (strong, nonatomic) NSCache *imageCache;

@end

@implementation MainPage



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    self.labelRestaurante.text = [Language textForIndex:@"Restaurante"];
    self.labelCidade.text = [Language textForIndex:@"Cidade"];
    self.labelOsMeusMenus.text = [Language textForIndex:@"Meus_menus"];
    
    //if (![Globals user]) {
    
    //}
    
    
}

-(void)viewDidAppear:(BOOL)animated
{
    
   // [self loadUser];
    [self loadUser];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden = YES;
    
    
    //self.labelRestaurante.text = [Language textForIndex:@"MainFrase1"];
    
    self.texfFieldPesquisa.delegate = self;
    
    [self.buttonCities setSelected:YES];
    tipo = @"Cities";
    
    [self setFontFamily:@"DKCrayonCrumble" forView:self.view andSubViews:YES];
    
    self.buttonRestaurant.titleLabel.font = [UIFont fontWithName:@"DKCrayonCrumble" size:20];
    self.buttonCities.titleLabel.font = [UIFont fontWithName:@"DKCrayonCrumble" size:20];
    self.buttonGo.titleLabel.font = [UIFont fontWithName:@"DKCrayonCrumble" size:18];
    self.texfFieldPesquisa.font = [UIFont fontWithName:@"DKCrayonCrumble" size:18];
    
    [NSThread detachNewThreadSelector:@selector(loadCities) toTarget:self withObject:nil];
    
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    
    UIColor *color = [UIColor lightTextColor];
    self.texfFieldPesquisa.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Procure ..." attributes:@{NSForegroundColorAttributeName: color}];
    
    
    
    // Set a default data source for all instances.  Otherwise, you can specify the data source on individual text fields via the autocompleteDataSource property
    

    [self setTextPadding:self.texfFieldPesquisa];
    
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singleTap];
    

   // [self makeLogin];
    
   
    
        

}



-(void)setTextPadding:(UITextField *)field
{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 20)];
    field.leftView = paddingView;
    field.leftViewMode = UITextFieldViewModeAlways;
}

- (void)handleSingleTap:(UITapGestureRecognizer *)sender
{
    [self.texfFieldPesquisa resignFirstResponder];
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

- (void)loadFaceImage
{
    NSString *str = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture", [Globals user].faceId];
    
    
    UIImage *image1 = [self.imageCache objectForKey:str];
    
    
    if (!image1) {
        NSData* data1 = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:str]];
        image1 = [UIImage imageWithData:data1];
        if (image1)
            [self.imageCache setObject:image1 forKey:str];
    }
    
    self.imageFacebook.image = image1;
    self.imageFacebook.layer.cornerRadius = self.imageFacebook.frame.size.height/2;
    self.imageFacebook.clipsToBounds = YES;
    self.imageFacebook.layer.borderWidth = 1.0f;
    self.imageFacebook.layer.borderColor = [UIColor whiteColor].CGColor;
    self.buttonGo.alpha = 0;
    self.labelUsername.text =[NSString stringWithFormat:@"Olá %@",[Globals user].name] ;
    self.labelUsername.font = [UIFont fontWithName:@"DKCrayonCrumble" size:22];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pushNav:(id)sender {
    //[self ChamarPesquisa];
      [self makeLogin];
}

-(void)ChamarPesquisa
{
    Resultados *c = [[Resultados alloc] initWithNibName:@"Resultados" bundle:nil];
    [c setResultado:self.texfFieldPesquisa.text];
    [c setTipo:tipo];
    [self.navigationController pushViewController:c animated:YES];
    PP_RELEASE(c);
}

- (IBAction)pushMenu:(id)sender {
    
    MenuRefugio *t = [[MenuRefugio alloc] init];
    UINavigationController *n = [[UINavigationController alloc] initWithRootViewController:t];
    [self.revealSideViewController pushViewController:n onDirection:PPRevealSideDirectionTop withOffset:t.view.frame.size.height animated:YES];
    PP_RELEASE(t);
    PP_RELEASE(n);

}

- (IBAction)ClickCitie:(id)sender {
    //[((UIButton *)sender) setSelected:YES];
    //[self.buttonRestaurant setSelected:NO];
    [self.imgSetectRest setImage:[UIImage imageNamed:@"noselect.png"]];
    [self.imgSelectcidate setImage:[UIImage imageNamed:@"select.png"]];
   
    self.texfFieldPesquisa.autocompleteType = HTAutocompleteTypeColor;
    
    tipo = @"Cities";
}

- (IBAction)ClickRestaurant:(id)sender {
    //[((UIButton *)sender) setSelected:YES];
    //[self.buttonCities setSelected:NO];
    [self.imgSetectRest setImage:[UIImage imageNamed:@"select.png"]];
    [self.imgSelectcidate setImage:[UIImage imageNamed:@"noselect.png"]];

    self.texfFieldPesquisa.autocompleteType = HTAutocompleteTypeRest;
    
    tipo = @"Restaurants";
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.texfFieldPesquisa) {
        [textField resignFirstResponder];
        [self ChamarPesquisa];
        return NO;
    }
    
    return YES;
}

#pragma mark - THREADED PARSERS

- (void)loadCities
{
    CitiesParser *citiesParser = [[CitiesParser alloc] initXMLParser];
    
    //    NSString *host = @"http://cms.citychef.pt/data/xml_cities.php";
    
    NSString *host = [Globals hostWithFile:@"xml_cities.php" andGetData:@""];
    NSLog(@"HOST NEW:%@", host);
    
    NSURL *url = [[NSURL alloc] initWithString: host];
    NSXMLParser *nsXmlParser = [[NSXMLParser alloc] initWithContentsOfURL: url];
    [nsXmlParser setDelegate:citiesParser];
    
    BOOL success = [nsXmlParser parse];
    
    
    if (success) {
        
       // [settingsVC refreshCities];
        
        //[self performSelectorOnMainThread:@selector(findNearest) withObject:nil waitUntilDone:NO];
        
        NSLog(@"success loaded cities");
        
        /*
        for (City * vitie in [Globals cities]) {
            NSLog(@"Citie name: %@ ",vitie.name);
        }
        */
        
        [HTAutocompleteTextField setDefaultAutocompleteDataSource:[HTAutocompleteManager sharedManager]];
        
        
        //self.emailTextField.keyboardType = UIKeyboardTypeEmailAddress;
        
        self.texfFieldPesquisa.autocompleteType = HTAutocompleteTypeColor;
        
    } else {
        
        NSError *error = [nsXmlParser parserError];
        
        NSLog(@"erro get restaurantes %@", error.description);
        
        [self performSelectorOnMainThread:@selector(noConnect) withObject:nil waitUntilDone:NO];
        
    }
}



- (void)noConnect
{
    
    alertBoo = [[UIAlertView alloc]
                             initWithTitle:[Language textForIndex:@"GlobalComErrorTitle"]
                             message:[Language textForIndex:@"GlobalComErrorText"]
                             delegate:self
                             cancelButtonTitle:@"OK"
                             otherButtonTitles:nil];
    
    [alertBoo show];
}


- (void)findNearest
{

}


-(void)makeLogin
{
    
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
            
            
        }];
   

}

- (IBAction)clickFav:(id)sender {
     //[self loadUser];
    
    if (![FBSession activeSession].isOpen) {
        alert = [[UIAlertView alloc] initWithTitle:@"Aviso" message:@"Para ter acesso a esta funcionalidade tem de ter login \ndeseja fazer agora?" delegate:self   cancelButtonTitle:@"Não" otherButtonTitles:@"Sim", nil];
        [alert show];
    }
    else{
        // abrir favoritos
        //[self loadUser];
        [self ChamarFavoritos];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
   
    if(alertView == alert){
        if (buttonIndex == 1) {
            [self makeLogin];
        }else{
            // nao faz nada
        }
    }
    if(alertView == alertBoo)
    {
        exit(0);
    }
    
    
    
}



- (void)loadUser
{
    NSLog(@"fazer login");
    __block NSString *msgtxt;
    if ([FBSession activeSession].isOpen) {
        [FBRequestConnection
         startForMeWithCompletionHandler:^(FBRequestConnection *connection, id<FBGraphUser> user, NSError *error) {
             
             
             
             msgtxt = [NSString stringWithFormat:@"%@  -  %@", user.id, user.name];
             
             //             NSLog(@"USER DATA:::%@  -  %@", user.id, user.name);
             
             if (![Globals user]) {
                 [Globals setUser:[[User alloc] init]];
             }
             
             [Globals user].email = [user objectForKey:@"email"];
             
             [Globals user].faceId = user.id;
             [Globals user].name = user.name;
             
           
             UserParser *userParser = [[UserParser alloc] initXMLParser];
             
             NSString *host = nil;
             
             //if (self.isOther) {
             //  host = [NSString stringWithFormat:@"http://cms.citychef.pt/data/xml_user.php?is_me=0&user_id=%d&face_id=%@", self.otherUserDbId, self.otherUserFaceId];
             //} else {
             host = [NSString stringWithFormat:@"http://80.172.235.34/~tecnoled/menuguru/rundlrweb/data/xml_user.php?is_me=1&user_id=%d&face_id=%@", [Globals user].dbId, [Globals user].faceId];
             //}
             NSLog(@"host: %@", host);
             
             NSURL *url = [[NSURL alloc] initWithString: host];
             NSXMLParser *nsXmlParser = [[NSXMLParser alloc] initWithContentsOfURL: url];
             [nsXmlParser setDelegate:userParser];
             
             BOOL success = [nsXmlParser parse];
             
             
             if (success) {
                 [self performSelectorOnMainThread:@selector(startUpContainers2) withObject:nil waitUntilDone:NO];
                 
             } else {
                 [self performSelectorOnMainThread:@selector(noConnect2) withObject:nil waitUntilDone:NO];
                 
             }

                }];
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
    
    //[self showFaceStuff];
    //[self loadUser];
    [self loadFaceImage];
}


- (void)noConnect2
{
    alertBoo2 = [[UIAlertView alloc]
                             initWithTitle:[Language textForIndex:@"GlobalComErrorTitle"]
                             message:[Language textForIndex:@"GlobalComErrorText"]
                             delegate:self
                             cancelButtonTitle:@"OK"
                             otherButtonTitles:nil];
    
    [alertBoo2 show];
}

#pragma mark - alertView delegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(alertView == alertBoo2)
    if (buttonIndex == 1) {
        NSString *phoneNumber = [@"tel://" stringByAppendingFormat:@"%d",[Globals restaurant].phone];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
    }
}


- (void)startUpContainers2
{
    [self loadFaceImage];
    // fax coisas aqui... yuppy
    //[self ChamarFavoritos];
    
}

-(void)ChamarFavoritos
{
    Resultados *c = [[Resultados alloc] initWithNibName:@"Resultados" bundle:nil];
    [c setResultado:self.texfFieldPesquisa.text];
    [c setTipo:@"Favoritos"];
    [self.navigationController pushViewController:c animated:YES];
    PP_RELEASE(c);
}




- (void)facebookLoginLogout
{
    if ([FBSession activeSession].isOpen) {
        [[FBSession activeSession] closeAndClearTokenInformation];
        
    } else {
        
    }
    
    
}




@end
