//
//  pesquiseCell.m
//  DinamicTable
//
//  Created by Hugo Costa on 31/01/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import "DefenicoesCell.h"

@implementation DefenicoesCell

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



- (IBAction)clickMensagem:(id)sender {
    if(self.delegate)
    {
        [self.delegate performSelector:@selector(selecionado:) withObject:[NSNumber numberWithDouble:6]];
    }
}

- (IBAction)clickEmail:(id)sender {
    if(self.delegate)
    {
        [self.delegate performSelector:@selector(selecionado:) withObject:[NSNumber numberWithDouble:7]];
    }

}

- (IBAction)clickFacebook:(id)sender {
    if(self.delegate)
    {
        [self.delegate performSelector:@selector(selecionado:) withObject:[NSNumber numberWithDouble:8]];
    }

}

- (IBAction)clickTwitter:(id)sender {
    if(self.delegate)
    {
        [self.delegate performSelector:@selector(selecionado:) withObject:[NSNumber numberWithDouble:9]];
    }

}
@end
