#import "LocationCell.h"
#import <AFNetworking/UIImage+AFNetworking.h>

@interface LocationCell ()

@property (weak, nonatomic) IBOutlet UILabel *locationName;
@property (weak, nonatomic) IBOutlet UILabel *locationAddress;
@property(strong, nonatomic) NSDictionary *locations;

@end

@implementation LocationCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)updateWithLocation:(NSDictionary *)locations {
    self.locationName.text = locations[@"name"];
    self.locationAddress.text = [locations valueForKeyPath:@"location.address"];
    
    //NSArray *categories = locations[@"categories"];
    //if (categories && categories.count > 0) {
        //NSDictionary *category = categories[0];
        //NSString *urlPrefix = [category valueForKeyPath:@"icon.prefix"];
        //NSString *urlSuffix = [category valueForKeyPath:@"icon.suffix"];
        //NSString *urlString = [NSString stringWithFormat:@"%@bg_32%@", urlPrefix, urlSuffix];
        
        //NSURL *url = [NSURL URLWithString:urlString];
        //[self.categoryImageView setImageWithURL:url];
    }

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
