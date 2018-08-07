//
//  FAQTableViewCell.h
//  rak
//
//  Created by Gustavo Coutinho on 8/6/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FAQ.h"
#import "Parse/Parse.h"

@interface FAQTableViewCell : UITableViewCell

@property (strong, nonatomic) FAQ *faq;

@property (weak, nonatomic) IBOutlet UILabel *questionText;
@property (weak, nonatomic) IBOutlet UILabel *answerText;

@end
