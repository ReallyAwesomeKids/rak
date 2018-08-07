#import "FAQTableViewCell.h"


@implementation FAQTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setFaq:(FAQ *)faq {
    _faq = faq;
    self.questionText.text = faq.text;
    self.answerText.text = faq.answer;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
