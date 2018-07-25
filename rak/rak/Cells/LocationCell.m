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
    }

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
