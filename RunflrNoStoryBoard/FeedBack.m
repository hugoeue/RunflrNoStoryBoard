//
//  FeedBack.m
//  RunflrNoStoryBoard
//
//  Created by Hugo Costa on 29/12/13.
//  Copyright (c) 2013 Hugo Costa. All rights reserved.
//

#import "FeedBack.h"
#import "WebServiceSender.h"

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
@end
