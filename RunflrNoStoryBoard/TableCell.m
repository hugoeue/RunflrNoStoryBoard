//
//  TableCell.m
//  RunflrNoStoryBoard
//
//  Created by Hugo Costa on 07/12/13.
//  Copyright (c) 2013 Hugo Costa. All rights reserved.
//

#import "TableCell.h"

@implementation TableCell

@synthesize label1= _label1 , label2 = _label2 , thumbnailImageView = _thumbnailImageView ,labeTitulo = _labeTitulo , ThumbnailSeta = _ThumbnailSeta;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
