//
//  MainPage.h
//  RunflrNoStoryBoard
//
//  Created by Hugo Costa on 02/12/13.
//  Copyright (c) 2013 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "HTAutocompleteTextField.h"

@interface MainPage : UIViewController <UITextFieldDelegate,CLLocationManagerDelegate>
{
    CLLocationManager *clManager;
}
@property (weak, nonatomic) IBOutlet UIImageView *imageHeader;

@property (weak, nonatomic) IBOutlet UIButton *buttonCities;
@property (weak, nonatomic) IBOutlet UIButton *buttonRestaurant;
@property (weak, nonatomic) IBOutlet UIButton *buttonGo;


- (IBAction)ClickCitie:(id)sender;
- (IBAction)ClickRestaurant:(id)sender;


@property (unsafe_unretained, nonatomic) IBOutlet HTAutocompleteTextField *texfFieldPesquisa;

@property (weak, nonatomic) IBOutlet UIImageView *imgSelectcidate;
@property (weak, nonatomic) IBOutlet UIImageView *imgSetectRest;

@property (weak, nonatomic) IBOutlet UILabel *labelRestaurante;

@property (weak, nonatomic) IBOutlet UIImageView *imageFacebook;


- (IBAction)clickFav:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *labelUsername;
@property (weak, nonatomic) IBOutlet UILabel *labelCidade;
@property (weak, nonatomic) IBOutlet UILabel *labelOsMeusMenus;

@end
