//
//  FormularioRegistoContaRundlr.h
//  RunflrNoStoryBoard
//
//  Created by Hugo Costa on 12/12/13.
//  Copyright (c) 2013 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FormularioRegistoContaRundlr : UIViewController <UITextFieldDelegate>{
    UIButton *currentBt;
    BOOL dateUp, numUp;
    NSString *checkInDate;

    int datePickerIndicator;
}

- (IBAction)Voltar:(id)sender;

@property (nonatomic , assign) id delegate;

@property (weak, nonatomic) IBOutlet UITextField *textNome;
@property (weak, nonatomic) IBOutlet UITextField *textUltimoNome;
@property (weak, nonatomic) IBOutlet UISegmentedControl *pickerSexo;
@property (weak, nonatomic) IBOutlet UITextField *textCidade;
@property (weak, nonatomic) IBOutlet UITextField *textEmail;
@property (weak, nonatomic) IBOutlet UITextField *textPassword;
@property (weak, nonatomic) IBOutlet UITextField *textPassword2;
@property (strong, nonatomic) UIDatePicker *datePicker;
@property (strong, nonatomic) UIView *dateView;
@property (weak, nonatomic) IBOutlet UIButton *dataNascimento;

- (IBAction)clickEnviarForm:(id)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *scroolView;

@end
