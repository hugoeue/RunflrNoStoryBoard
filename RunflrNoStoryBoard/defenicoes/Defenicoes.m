//
//  Defenicoes.m
//  RunflrNoStoryBoard
//
//  Created by Hugo Costa on 25/12/13.
//  Copyright (c) 2013 Hugo Costa. All rights reserved.
//

#import "Defenicoes.h"
#import "SobreMenuGuru.h"
#import "FeedBack.h"
#import "DemoRootViewController.h"
#import "TableDefenicoes.h"

#import "ShareViewController.h"

@interface Defenicoes (){
    TableDefenicoes * defenicoes;
}

@end

@implementation Defenicoes


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
    
    
    // para apenas o botao de voltar atras
    self.title = [Language textForIndex:@"Definicoes"];
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 25, 25)];
    [button addTarget:self action:@selector(ClickAnterior:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"b_menu.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    //[anotherButton setImage:[UIImage imageNamed:@"b_back.png"]];
    
    
    self.navigationItem.leftBarButtonItem = anotherButton;
    
    
    CGRect frame = CGRectMake(0, 0, 100, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:frame] ;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:101.0/255.0 green:112.0/255.0 blue:122.0/255.0 alpha:1];
    label.text = [Language textForIndex:@"Definicoes"];
    self.navigationItem.titleView = label;
    
    ////////////////////////////////////////////////////
    
    
    
    [self escurecer:0.0];
    [self escurecer:0.5];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden = NO;
    
//    self.labelDefeniçoes.text =[Language textForIndex:@"Definicoes"]; 
//    self.labelPolitica.text =[Language textForIndex:@"Politica_privacidade"];
//    self.labelSobre.text =[Language textForIndex:@"Sobre_Menu_Guru"];
//    self.labelTermos.text =[Language textForIndex:@"Termos_condicoes"];
//    self.labelFeedBack.text =[Language textForIndex:@"Feedback"];
//    
//    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clarear)];
//    [self.viewPretaGrande addGestureRecognizer:singleTap];
//    
//    [Utils mudaBarraParaSeIos7:UIStatusBarStyleLightContent];
//    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//    
//    self.imagemTopo.image = [Globals getImagemGenerica];
    
    
    defenicoes = [TableDefenicoes new];
    [defenicoes.view setFrame:self.container.frame];
    defenicoes.delegate = self;
    [self.view addSubview:defenicoes.view];
}

-(void)clarear
{
    [self escurecer:0.5];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ClickAnterior:(id)sender {
    //[self.navigationController popToRootViewControllerAnimated:YES];
    
//    [[DemoRootViewController getInstance] chamarOutroTopo];
    //[self escurecer:0.0];
    [self escurecer:0.5];
    [self.revealSideViewController pushOldViewControllerOnDirection:PPRevealSideDirectionLeft animated:YES];
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



- (IBAction)clicksobreGuru:(id)sender {
    SobreMenuGuru * termos = [SobreMenuGuru new];
    termos.titulo = [Language textForIndex:@"Sobre_Menu_Guru"];
    
    if ([[Globals lang] isEqualToString:@"pt"]) {
        NSLog(@"lingua em pt");
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Sobre nosPT" ofType:@"txt"];
        NSString *userAgreement = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
        termos.conteudo = userAgreement;
    }
    else{
        NSLog(@"lingua em %@", [Globals lang]);
        NSString *path = [[NSBundle mainBundle] pathForResource:@"About Us" ofType:@"txt"];
        NSString *userAgreement = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
        termos.conteudo = userAgreement;
        
    }

    [self.navigationController pushViewController:termos animated:YES];
}

- (IBAction)clickFeedBack:(id)sender {
    [self.navigationController pushViewController:[FeedBack new] animated:YES];
}


- (IBAction)clickTermos:(id)sender {
    SobreMenuGuru * termos = [SobreMenuGuru new];
    termos.titulo = [Language textForIndex:@"Termos_condicoes"];

    
    if ([[Globals lang] isEqualToString:@"pt"]) {
        NSLog(@"lingua em pt");
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Termos e condiçõesPT" ofType:@"txt"];
        NSString *userAgreement = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
        termos.conteudo = userAgreement;
    }
    else{
        NSLog(@"lingua em %@", [Globals lang]);
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Terms and Conditions" ofType:@"txt"];
        NSString *userAgreement = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
        termos.conteudo = userAgreement;
        
    }

    
     [self.navigationController pushViewController:termos animated:YES];
}

- (IBAction)clickPolitica:(id)sender {
    SobreMenuGuru * termos = [SobreMenuGuru new];
    termos.titulo = [Language textForIndex:@"Politica_privacidade"];
    
    if ([[Globals lang] isEqualToString:@"pt"]) {
        NSLog(@"lingua em pt");
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Política de privacidadePT" ofType:@"txt"];
        NSString *userAgreement = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
        termos.conteudo = userAgreement;
    }
    else{
        NSLog(@"lingua em %@", [Globals lang]);
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Privacy Policy" ofType:@"txt"];
        NSString *userAgreement = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
        termos.conteudo = userAgreement;
        
    }

    
    [self.navigationController pushViewController:termos animated:YES];
}




// Optional Methods

-(UIColor *)colorForCollapseClickTitleViewAtIndex:(int)index {
    return [UIColor colorWithRed:223/255.0f green:47/255.0f blue:51/255.0f alpha:1.0];
}


-(UIColor *)colorForTitleLabelAtIndex:(int)index {
    return [UIColor colorWithWhite:1.0 alpha:0.85];
}

-(UIColor *)colorForTitleArrowAtIndex:(int)index {
    return [UIColor colorWithWhite:0.0 alpha:0.25];
}

-(void)didClickCollapseClickCellAtIndex:(int)index isNowOpen:(BOOL)open {
    NSLog(@"%d and it's open:%@", index, (open ? @"YES" : @"NO"));
}


#pragma mark - TextField Delegate for Demo
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}



-(void)chamaremail
{
    NSArray *toRecipents = [NSArray arrayWithObject:@"menu@uru.come"];
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:@""];
    [mc setMessageBody:@"" isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    mc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:mc animated:YES completion:NULL];
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)clickClassifica:(id)sender {
    
    NSString* launchUrl = @"http://www.google.com";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: launchUrl]];
}

// para partinhar no facebook
- (IBAction)shareFacebookClicked:(id)sender
{
    if (![FBSession activeSession].isOpen) {
        [self loginButton:self];
        return;
    }
    
    
    ShareViewController *viewController = [[ShareViewController alloc]
                                           initWithNibName:@"ShareViewController"
                                           bundle:nil];
    
    //    if ([Globals restaurant].images.count > 0) {
    //        NSString *imagePath = [[Globals restaurant].images objectAtIndex:0];
    //        viewController.imagePath = [NSString stringWithFormat:@"http://cms.citychef.pt%@", imagePath ];
    //    }
    
    viewController.imagePath = [NSString stringWithFormat:@"http://80.172.235.34/~tecnoled/%@",[Globals getImagemFeedBack]];
    
    viewController.restName = [Language textForIndex:@"MsgFace"];
    viewController.restAddress = @"titulo 2";
    //viewController.rest = @"titulo 3";
    
    //[self presentViewController:viewController animated:YES completion:nil];
    [self.navigationController pushViewController:viewController animated:YES];
}

// minhas cenas
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
                    [self shareFacebookClicked:self];
                }
            }];
            
            
            // [self.navigationController popToRootViewControllerAnimated:YES];
        }];
    }else{
        //[self.navigationController popToRootViewControllerAnimated:YES];
        
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
        //             NSLog(@"USER DATA:::%@  -  %@", user.id, user.name);
        
        [Globals user].email = [user objectForKey:@"email"];
        
        [Globals user].faceId = user.id;
        [Globals user].name = user.name;
        if(![Globals user].dbId)
            [Globals user].loginType = @"facebook";
        
        
        //    [self dismissViewControllerAnimated:YES completion:nil];
        //    [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
    

}

- (IBAction)clickSMS:(id)sender {
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    if([MFMessageComposeViewController canSendText])
    {
        controller.body = [Language textForIndex:@"MsgSMS"];
        controller.recipients = [NSArray arrayWithObjects:@" ", nil];
        controller.messageComposeDelegate = self;
        controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:controller animated:YES completion:nil];
    }
}


- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [controller dismissViewControllerAnimated:YES completion:nil];
    
    if (result == MessageComposeResultCancelled)
        NSLog(@"Message cancelled");
    else if (result == MessageComposeResultSent)
        NSLog(@"Message sent");
    else
        NSLog(@"Message failed");
}


-(void)chamaremailAmigos
{
    NSArray *toRecipents = [NSArray arrayWithObject:@" "];
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:@""];
    [mc setMessageBody:[Language textForIndex:@"MsgEmail"] isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    
     mc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:mc animated:YES completion:NULL];
}

#pragma cenas para a table defeniçoes

-(void)indexSelected:(NSNumber *)index
{
    NSLog(@"selected button %f",index.doubleValue);
    
    if (index.doubleValue == 0) {
        [self clicksobreGuru:self];
    }else if (index.doubleValue == 1) {
        [self clickTermos:self];
    }else if (index.doubleValue == 2) {
        [self clickPolitica:self];
    }else if (index.doubleValue == 3) {
        // aqui tem de fazer outras cenas mas nem faz aqui
        // ou secalhar chamar mesmo outro metodo para fazer as cenas
        
    }else if (index.doubleValue == 4) {
        [self chamaremail];
    }else if (index.doubleValue == 5) {
        [self clickClassifica:self];
    }
    else if (index.doubleValue == 6) {
        // sms
        [self clickSMS:self];
    }
    else if (index.doubleValue == 7) {
        [self chamaremailAmigos];
    }
    else if (index.doubleValue == 8) {
        // facebook
        [self shareFacebookClicked:self];
    }
    else if (index.doubleValue == 9) {
        // twitter
    }
}

@end
