//
//  QueroMais.m
//  RunflrNoStoryBoard
//
//  Created by Hugo Costa on 29/01/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import "QueroMais.h"
#import "WebServiceSender.h"

@interface QueroMais ()
{
    WebServiceSender * enviar;
    Restaurant * restaurante;
    
    BOOL dia;
    BOOL esp;
    BOOL eme;
    
}

@end

@implementation QueroMais

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithRestaurant:(Restaurant *)rest
{
    self = [super init];
    if (self) {
        // Custom initialization
        restaurante = rest;
    }
    return self;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.navigationController.navigationBarHidden = YES;
    
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonDidPressed:)];
    UIBarButtonItem *flexableItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:NULL];
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    [toolbar setItems:[NSArray arrayWithObjects:flexableItem,doneItem, nil]];
    self.textArea.inputAccessoryView = toolbar;
}


- (void)doneButtonDidPressed:(id)sender {
    [self.textArea resignFirstResponder];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    if (enviar) {
        [enviar cancel];
    }
    enviar = nil;
}

-(void)enviarCoisas
{

    if (enviar) {
        [enviar cancel];
    }
     enviar = [[WebServiceSender alloc] initWithUrl:@"http://80.172.235.34/~tecnoled/menuguru/rundlrweb/data/json_email_interesse_menu.php" method:@"" tag:1];
    enviar.delegate = self;
    
    NSMutableDictionary * dict = [NSMutableDictionary new];
    
    // tudo que a tania precisa para enviar email
    /*
     
     $body['lang'];
     $body['rest_nome'];//"Cantina da Baldraca";//
     $body['rest_cidade'];//"Lisboa";//
     $body['user_id'];//"Felgueiras";//
     $body['user_nome'];//"Felgueiras";//
     $body['menus'];//"menu especial, menu do dia";//
     $body['sugestao']
     
     */
    
    NSString * interessado =@"";
    
    if (dia) {
        interessado = @"menu dia, ";
    }
    if (esp) {
        interessado = [NSString stringWithFormat:@"%@menu especial, ",interessado];
    }
    if (eme) {
        interessado = [NSString stringWithFormat:@"%@menu ementa, ",interessado];
    }
    
    [dict setObject:restaurante.name forKey:@"rest_name"];
    [dict setObject:restaurante.city forKey:@"rest_cidade"];

    [dict setObject: [Globals user].name forKey:@"user_nome"];
    [dict setObject:restaurante.name forKey:@"menus"];
    [dict setObject: self.textArea.text forKey:@"sugestao"];
    
    if([Globals user].faceId)
    {
        [dict setObject: [Globals user].faceId forKey:@"face_id"];
        [dict setObject: [NSString stringWithFormat:@"%d", 0] forKey:@"user_id"];
    }else
    {
        [dict setObject: [NSString stringWithFormat:@"%d", 0] forKey:@"face_id"];
        [dict setObject: [NSString stringWithFormat:@"%d", [Globals user].dbId] forKey:@"user_id"];
    }

    [dict setObject: interessado forKey:@"menus"];
    
   
    
    [enviar sendDict:dict];
    
}

-(void)sendCompleteWithResult:(NSDictionary*)result withError:(NSError*)error{
    
    
    if (!error)
    {
        int tag=[WebServiceSender getTagFromWebServiceSenderDict:result];
        switch (tag)
        {
            case 1:
            {
                NSLog(@"resultado de quero mais => %@", result.description);
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }
    }else
    {
        NSLog(@"error webserviceSender %@",error);
    }
}


- (IBAction)ClickSubmeter:(id)sender {
    [self enviarCoisas];
}

- (IBAction)Close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)setImgDiaSelected:(BOOL) selected
{
    if (selected) {
        [self.imgDia setImage:[UIImage imageNamed:@"botao_no_select.png"]];
    }else
    {
        [self.imgDia setImage:[UIImage imageNamed:@"botao_select.png"]];
    }
}

-(void)setImgEspSelected:(BOOL) selected
{
    if (selected) {
        [self.imgEsp setImage:[UIImage imageNamed:@"botao_no_select.png"]];
    }else
    {
        [self.imgEsp setImage:[UIImage imageNamed:@"botao_select.png"]];
    }
}

-(void)setImgEmeSelected:(BOOL) selected
{
    if (selected) {
        [self.imgEme setImage:[UIImage imageNamed:@"botao_no_select.png"]];
    }else
    {
        [self.imgEme setImage:[UIImage imageNamed:@"botao_select.png"]];
    }
}

- (IBAction)clickDia:(id)sender {
    [self setImgDiaSelected:dia];
    dia=!dia;
}

- (IBAction)clickEsp:(id)sender {
    [self setImgEspSelected:esp];
    esp=!esp;
}

- (IBAction)clickEme:(id)sender {
    [self setImgEmeSelected:eme];
    eme=!eme;
}
@end
