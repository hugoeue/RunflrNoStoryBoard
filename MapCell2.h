//
//  mapCell.h
//  Match3Draft
//
//  Created by iObitLXF on 2/21/13.
//  Copyright (c) 2013 iObitLXF. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ButtonType_Profile2 = 0,
    ButtonType_Distance2,
    ButtonType_More2,

}ButtonType2;

typedef void (^ClickButtonBlock2)(ButtonType2 aType);

@class PlaceDetailVO;
@interface MapCell2 : UIView

@property (weak, nonatomic) IBOutlet UIImageView *imageViewBg;
@property (weak, nonatomic) IBOutlet UIButton *buttonItem1;
@property (weak, nonatomic) IBOutlet UIButton *buttonItem2;
@property (weak, nonatomic) IBOutlet UIButton *buttonItem3;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;

@property (nonatomic,strong)PlaceDetailVO   *placeDetailVO;

@property (nonatomic,strong)ClickButtonBlock2    blockButton;
@property (weak, nonatomic) IBOutlet UILabel *hotelName;

+(MapCell2*)getInstanceWithNibWithBlock2:(ClickButtonBlock2)aBlock;
-(void)toAppearItemsView;

@end
