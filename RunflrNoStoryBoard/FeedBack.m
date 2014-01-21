//
//  FeedBack.m
//  RunflrNoStoryBoard
//
//  Created by Hugo Costa on 29/12/13.
//  Copyright (c) 2013 Hugo Costa. All rights reserved.
//

#import "FeedBack.h"
#import "WebServiceSender.h"
#import "ShareViewController.h"

@interface FeedBack ()
{
    
    NSString *emailTitle;
    // Email Content
    NSString *messageBody;
    // To address
    NSArray *toRecipents;
    
    WebServiceSender * web;

}

@end

@implementation FeedBack

-(void)carregarLingua
{
    self.labelTitulo.text = [Language textForIndex:@"Feedback"];
    self.LabelOquePensas.text = [Language textForIndex:@"Diz_que_pensas"];
    self.labelClassifica.text = [Language textForIndex:@"Classifica_App"];
    self.labelPartilha.text = [Language textForIndex:@"Partilha_com_amigos"];
    self.labelSMS.text = [Language textForIndex:@"SMS"];
    self.labelEmail.text = [Language textForIndex:@"Email"];
    self.LabelFacebook.text = [Language textForIndex:@"Facebook"];
    
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
    [self carregarLingua];
    
    self.imagemTopo.image = [Globals getImagemGenerica];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)voltar:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)clickSMS:(id)sender {
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    if([MFMessageComposeViewController canSendText])
    {
        controller.body = [Language textForIndex:@"MsgSMS"];
        controller.recipients = [NSArray arrayWithObjects:@" ", nil];
        controller.messageComposeDelegate = self;
        [self presentViewController:controller animated:YES completion:nil];
    }
}

-(void)chamarWebServiceOQP
{
    
    web = [[WebServiceSender alloc] init];
    web.delegate = self;
    
}

- (IBAction)clickDisnosOQuePensas:(id)sender {
    
    [self chamaremail];
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
    [self presentViewController:mc animated:YES completion:NULL];
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
- (IBAction)clickClassifica:(id)sender {
    
    NSString* launchUrl = @"http://www.google.com";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: launchUrl]];
}

- (IBAction)clickEmailAmigos:(id)sender {
    
    [self chamaremailAmigos];
    
}
- (IBAction)clickFacebook:(id)sender {
    
    [FBSettings setLoggingBehavior:[NSSet setWithObjects:FBLoggingBehaviorFBRequests, FBLoggingBehaviorFBURLConnections, nil]];
    
    
    
    [self shareFacebookClicked:self];

}

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
    }
    
    
    
    //             NSLog(@"USER DATA:::%@  -  %@", user.id, user.name);
    
    [Globals user].email = [user objectForKey:@"email"];
    
    [Globals user].faceId = user.id;
    [Globals user].name = user.name;
    if(![Globals user].dbId)
        [Globals user].loginType = @"facebook";
    
    
//    [self dismissViewControllerAnimated:YES completion:nil];
//    [self.navigationController popToRootViewControllerAnimated:YES];
    
    
}


@end
