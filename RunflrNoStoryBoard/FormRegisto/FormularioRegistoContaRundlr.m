//
//  FormularioRegistoContaRundlr.m
//  RunflrNoStoryBoard
//
//  Created by Hugo Costa on 12/12/13.
//  Copyright (c) 2013 Hugo Costa. All rights reserved.
//

#import "FormularioRegistoContaRundlr.h"
#import "WebServiceSender.h"
#import "User.h"

@interface FormularioRegistoContaRundlr ()
{
    WebServiceSender * enviaForm;

}

@end

@implementation FormularioRegistoContaRundlr

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)enviarFormulario
{
    enviaForm = [[WebServiceSender alloc] initWithUrl:@"http://80.172.235.34/~tecnoled/menuguru/rundlrweb/data/json_login.php" method:@"" tag:1];
    enviaForm.delegate = self;
    
    NSMutableDictionary * dict = [NSMutableDictionary new];
    
    
//    $email=$body['email'];
//    $cidade=$body['cidade'];
//    $genero=$body['genero'];
//    $data_nasc=$body['data_nasc'];
//    $password=$body['password'];
//    $facebookId=$body['face'];
    
    
    
    NSDate *date =  self.datePicker.date;
    
    

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *dateString = [formatter stringFromDate:date];
    
    NSLog(@"a data de nascimento => %@",dateString);
    
    [dict setObject:dateString forKey:@"data_nasc"];
    
    NSString * sexo;
    if(self.pickerSexo.selectedSegmentIndex == 0)
    {
        sexo = @"homem";
    }else
    {
        sexo = @"mulher";
    }
    
    NSString * faceID = @"1";
    
    [dict setObject:sexo forKey:@"genero"];
    [dict setObject:self.textNome.text forKey:@"primnome"];
    [dict setObject:self.textUltimoNome.text forKey:@"segnome"];
    [dict setObject:self.textEmail.text forKey:@"email"];
    [dict setObject:self.textCidade.text forKey:@"cidade"];
    [dict setObject:self.textPassword.text forKey:@"password"];
    
    if([Globals user].faceId){
        [dict setObject:[Globals user].faceId forKey:@"face"];
    }else
    {
        [dict setObject:faceID forKey:@"face"];
    }
    
    [enviaForm sendDict:dict];
    
}

-(void)sendCompleteWithResult:(NSDictionary*)result withError:(NSError*)error{
    
    
    if (!error)
    {
        int tag=[WebServiceSender getTagFromWebServiceSenderDict:result];
        switch (tag)
        {
            case 1:
            {
                NSLog(@"resultado da tania no registo =>%@", result.description);
                
                //resp = "Successfully inserted 1 row";
                if([[result objectForKey:@"resp"] isEqualToString:@"Successfully inserted 1 row"])
                {
                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Sucesso" message:@"Resgisto realizado com sucesso" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                    [alert show];
                    
                    
                    User *regUser = [User new];
                    regUser.dbId = [[result objectForKey:@"userid"] integerValue];
                    regUser.name = [result objectForKey:@"pnome"];
                    regUser.email = [result objectForKey:@"email"];
                    regUser.loginType = @"guru";
                    
                    
                    [Globals setUser:regUser];
                    
                }else{
                    
                }
                
               
                break;
            }
                
        }
    }else
    {
        NSLog(@"error paulo %@",error);
        
    }
    
    
}


- (IBAction)checkInAction:(UIButton *)sender {
    NSString *title;
    if(dateUp) {
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        df.dateStyle = NSDateFormatterMediumStyle;
        title = [df stringFromDate:_datePicker.date];
        NSLog(@"%@",title);
        
        [currentBt setTitle:title forState:UIControlStateNormal];
    } else {
        
        [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            CGRect pickerFrame = _dateView.frame;
            pickerFrame.origin.y -= 256;
            _dateView.frame = pickerFrame;
            
        } completion:nil];
    }
    
    currentBt = sender;
    dateUp = YES;
    
    datePickerIndicator = 0;
    NSLog(@"%@",checkInDate);
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    //[self.view addGestureRecognizer:singleTap];
  
    
//    float sizeOfContent = 700;
//    UIView *lLast = [self.scroolView.subviews lastObject];
//    NSInteger wd = lLast.frame.origin.y;
//    NSInteger ht = lLast.frame.size.height;
//    
//    sizeOfContent = wd+ht;
    
    self.scroolView.contentSize = CGSizeMake(self.scroolView.frame.size.width, 1000);

    
    
    self.dateView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, 320, 256)];
    [self.view addSubview:_dateView];
    
    UIToolbar *dateToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    dateToolbar.barStyle = UIBarStyleBlackTranslucent;
    [_dateView addSubview:dateToolbar];
    
    UIBarButtonItem *doneDateBt = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(addDate:)];
    //UIBarButtonItem *flexDateSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:@selector(addDate:)];
    dateToolbar.items = [[NSArray alloc] initWithObjects: doneDateBt, nil];
    
    
    _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 40, 320, 216)];
    _datePicker.datePickerMode = UIDatePickerModeDate;
    _datePicker.backgroundColor = [UIColor whiteColor];
    
    CGRect frame = self.datePicker.frame;
    frame.size.width -= 100;
    [_datePicker setFrame: CGRectMake(0, 40, 320, 216)];
    
    [_dateView addSubview:_datePicker];

    [self.scroolView setContentOffset:CGPointMake(0, 20) animated:YES];
}



- (void)addDate:(UIBarButtonItem *)_sender {
    
    
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGRect pickerFrame = _dateView.frame;
        pickerFrame.origin.y += 256;
        _dateView.frame = pickerFrame;
    } completion:nil];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateStyle = NSDateFormatterMediumStyle;
    NSString *title = [df stringFromDate:_datePicker.date];
    [currentBt setTitle:title forState:UIControlStateNormal];
    
    
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *title2 = [dateFormat stringFromDate:_datePicker.date];
    NSLog(@"%@",title2);
    
    if(datePickerIndicator == 0)
    {
        checkInDate = title2;
        
    }
    
    currentBt = nil;
    dateUp = NO;
}


- (void)handleSingleTap:(UITapGestureRecognizer *)sender
{
    [self.view resignFirstResponder];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickEnviarForm:(id)sender {
    NSString  *possoenviar = @"";
    
    NSString *emailid = self.textEmail.text;
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest =[NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL myStringMatchesRegEx=[emailTest evaluateWithObject:emailid];
    if (!myStringMatchesRegEx ) {
        possoenviar = @"Email invalido";
    }
    
    if(![self.textPassword.text isEqualToString:self.textPassword2.text])
    {
        possoenviar =[NSString stringWithFormat:@"%@ Password tem de ser igual",possoenviar];
    }
    if (possoenviar.length ==0 )
    {
        [self enviarFormulario];
    }else{
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Erro" message:possoenviar delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}
- (IBAction)Voltar:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
