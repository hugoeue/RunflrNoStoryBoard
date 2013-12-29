//
//  FeedBack.h
//  RunflrNoStoryBoard
//
//  Created by Hugo Costa on 29/12/13.
//  Copyright (c) 2013 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SobreMenuGuru : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *textArea;
@property (weak, nonatomic) IBOutlet UILabel *labelTitulo;

@property NSString * titulo;
@property NSString * conteudo;

@end
