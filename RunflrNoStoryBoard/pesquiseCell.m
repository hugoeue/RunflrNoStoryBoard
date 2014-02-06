//
//  pesquiseCell.m
//  DinamicTable
//
//  Created by Hugo Costa on 31/01/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import "pesquiseCell.h"

@implementation pesquiseCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
<<<<<<< HEAD
       self.preco = @"0";
=======
       
>>>>>>> a2bd55e3ef196190c15586c92915654ad041e6fe
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
    self.textField.delegate = self;
     self.labelSlider.text = @"Todos";

}


- (IBAction)sliederMoved:(id)sender {
    
     NSLog(@"slider mexeu para %f",self.slider.value);
    
    
    if (self.slider.value == 0) {
        self.labelSlider.text = @"Todos";
<<<<<<< HEAD
        self.preco = @"0";
    }else if(self.slider.value <=1)
    {
        self.labelSlider.text = @"< 15";
        self.preco = @"1";
    }else if(self.slider.value <=2)
    {
        self.labelSlider.text = @"< 30";
        self.preco = @"2";
    }else if(self.slider.value <3)
    {
        self.labelSlider.text = @"< 50";
        self.preco = @"3";
    }else if(self.slider.value == 3)
    {
        self.labelSlider.text = @"> 50";
        self.preco = @"4";
=======
    }else if(self.slider.value <=1)
    {
        self.labelSlider.text = @"< 15";
    }else if(self.slider.value <=2)
    {
        self.labelSlider.text = @"< 30";
    }else if(self.slider.value <3)
    {
        self.labelSlider.text = @"< 50";
    }else if(self.slider.value == 3)
    {
        self.labelSlider.text = @"> 50";
>>>>>>> a2bd55e3ef196190c15586c92915654ad041e6fe
    }
    
}

- (IBAction)selectorSelected:(id)sender {
    
<<<<<<< HEAD
=======
   
    
    
>>>>>>> a2bd55e3ef196190c15586c92915654ad041e6fe
}

- (IBAction)selectedTexfield:(id)sender {
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [self.textField resignFirstResponder];
    return YES;
}


@end
