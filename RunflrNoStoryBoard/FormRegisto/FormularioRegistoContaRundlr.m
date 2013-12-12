//
//  FormularioRegistoContaRundlr.m
//  RunflrNoStoryBoard
//
//  Created by Hugo Costa on 12/12/13.
//  Copyright (c) 2013 Hugo Costa. All rights reserved.
//

#import "FormularioRegistoContaRundlr.h"
#import "WebServiceSender.h"

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
    enviaForm = [[WebServiceSender alloc] initWithUrl:@"" method:@"" tag:1];
    enviaForm.delegate = self;
    
    NSMutableDictionary * dict = [NSMutableDictionary new];
    
    [dict setObject:self.textNome.text forKey:@"nome"];
    [dict setObject:self.textEmail.text forKey:@"email"];
    [dict setObject:self.textCidade.text forKey:@"cidade"];
    [dict setObject:self.textPassword.text forKey:@"password"];
    
//    NSDate *date =  self.pickerDataNascimento.date;
//    
//    NSString *dateString = [NSDateFormatter localizedStringFromDate:date
//                                                          dateStyle:NSDateFormatterShortStyle
//                                                          timeStyle:NSDateFormatterFullStyle];
//    NSLog(@"%@",dateString);
//    
//    [dict setObject:dateString forKey:@"datanascimaneto"];
    
    NSString * sexo;
    if(self.pickerSexo.selectedSegmentIndex == 0)
    {
        sexo = @"homem";
    }else
    {
        sexo = @"mulher";
    }
    
    [dict setObject:sexo forKey:@"sexo"];
    
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
                NSLog(@"resultado da tania  %@", result.description);
                
               
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
        if(numUp) {
            
            
            numUp = NO;
        }
        
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
    [self.view addGestureRecognizer:singleTap];
  
    
    float sizeOfContent = 700;
    UIView *lLast = [self.scroolView.subviews lastObject];
    NSInteger wd = lLast.frame.origin.y;
    NSInteger ht = lLast.frame.size.height;
    
    sizeOfContent = wd+ht;
    
    self.scroolView.contentSize = CGSizeMake(self.scroolView.frame.size.width, 1000);

    
    self.dateView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, 320, 256)];
    [self.view addSubview:_dateView];
    
    UIToolbar *dateToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    dateToolbar.barStyle = UIBarStyleBlackTranslucent;
    [_dateView addSubview:dateToolbar];
    
    UIBarButtonItem *doneDateBt = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(addDate:)];
    UIBarButtonItem *flexDateSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    dateToolbar.items = [[NSArray alloc] initWithObjects:flexDateSpace, doneDateBt, nil];
    
    
    _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 40, 320, 216)];
    _datePicker.datePickerMode = UIDatePickerModeDate;
    _datePicker.backgroundColor = [UIColor whiteColor];
    
    CGRect frame = self.datePicker.frame;
    frame.size.width -= 100;
    [_datePicker setFrame: CGRectMake(0, 40, 320, 216)];
    
    [_dateView addSubview:_datePicker];

    
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
    [self enviarFormulario];
}
@end
