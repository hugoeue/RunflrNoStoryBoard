//
//  pesquiseCell.h
//  DinamicTable
//
//  Created by Hugo Costa on 31/01/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface pesquiseCell : UITableViewCell <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *labelSlider;
@property (weak, nonatomic) IBOutlet UISegmentedControl *selector;
@property (weak, nonatomic) IBOutlet UITextField *textField;

<<<<<<< HEAD
@property (nonatomic , assign) id delegate;

@property NSString *preco;

=======
>>>>>>> a2bd55e3ef196190c15586c92915654ad041e6fe
@end
