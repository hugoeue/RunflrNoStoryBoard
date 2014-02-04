//
//  Voucher.m
//  RunflrNoStoryBoard
//
//  Created by Hugo Costa on 30/01/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import "Voucher.h"
#import "WebServiceSender.h"

@interface Voucher ()
{
    WebServiceSender *voucher;
    
    Restaurant * restaurant;
}

@end

@implementation Voucher

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithRestaurant:(Restaurant *)rest
{
    self = [super init];
    if (self) {
        restaurant = rest;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden = YES;
    
    
    // para o butão do teclado de voltar
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonDidPressed:)];
    UIBarButtonItem *flexableItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:NULL];
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    [toolbar setItems:[NSArray arrayWithObjects:flexableItem,doneItem, nil]];
    self.textField.inputAccessoryView = toolbar;
    
    [self pedirVoucher];
}

-(void)pedirVoucher
{
    if (voucher) {
        [voucher cancel];
    }
    
    voucher = [[WebServiceSender alloc] initWithUrl:@"http://80.172.235.34/~tecnoled/menuguru/rundlrweb/data/json_gerar_codigo_reserva2.php" method:@"" tag:1];
    
    voucher.delegate = self;
    
    
    
    NSMutableDictionary * dict = [NSMutableDictionary new];
    
    NSString * restID = [NSString stringWithFormat:@"%d",restaurant.dbId];
    

    
    [dict setObject:restaurant.pai forKey:@"id_especial_pai"];
    [dict setObject:restaurant.chef forKey:@"id_especial"];
    
    

    
    if([Globals user].faceId)
    {
        [dict setObject: [Globals user].faceId forKey:@"face_id"];
        [dict setObject: [NSString stringWithFormat:@"%d", 0] forKey:@"user_id"];
    }else
    {
        [dict setObject: [NSString stringWithFormat:@"%d", 0] forKey:@"face_id"];
        [dict setObject: [NSString stringWithFormat:@"%d", [Globals user].dbId] forKey:@"user_id"];
    }

    
    [voucher sendDict:dict];
    
}

-(void)sendCompleteWithResult:(NSDictionary*)result withError:(NSError*)error{
    
    
    if (!error)
    {
        int tag=[WebServiceSender getTagFromWebServiceSenderDict:result];
        switch (tag)
        {
            case 1:
            {
                NSLog(@"resultado de voucher => %@", result.description);
                
                /*
                "codigo_bloqueio" = "5227-ETEP-6429";
                "id_especial" = 1;
                res = "j\U00e1 feita reserva";
                "user_id" = 788;
                validade = 1;

                */
                
                self.voucher.text = [result objectForKey:@"codigo_bloqueio"];
            }
        }
    }else
    {
        NSLog(@"error webserviceSender voucher %@",error);
    }
}

- (void)doneButtonDidPressed:(id)sender {
    [self.textField resignFirstResponder];
    [self close:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
