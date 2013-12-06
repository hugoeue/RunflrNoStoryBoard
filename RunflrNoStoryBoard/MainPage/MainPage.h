//
//  MainPage.h
//  RunflrNoStoryBoard
//
//  Created by Hugo Costa on 02/12/13.
//  Copyright (c) 2013 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

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

@property (weak, nonatomic) IBOutlet UITextField *texfFieldPesquisa;


@end
