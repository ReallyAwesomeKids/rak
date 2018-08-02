#import "AddActViewController.h"
#import "ActCategory.h"
#import <CCDropDownMenus/CCDropDownMenus.h>

@interface AddActViewController () <CCDropDownMenuDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userActName;
@property (strong, nonatomic) NSString *name;
@property (strong,nonatomic) NSArray *categories;
@property (strong,nonatomic) NSArray *acts;
@property (nonatomic, strong) ManaDropDownMenu *menu1;

- (IBAction)didTapDone:(id)sender;

@end

@implementation AddActViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self menuSetup];
    
    
}

- (void)menuSetup {
    CGRect frame = CGRectMake((CGRectGetWidth(self.view.frame)-240)/2, 80, 240, 37);
    self.menu1 = [[ManaDropDownMenu alloc] initWithFrame:frame title:@"Choose a category"];
    self.menu1.delegate = self;
    self.menu1.numberOfRows = 6;
    self.menu1.textOfRows = @[@"Local Needs", @"Dating", @"Friends", @"Work", @"Community", @"Family"];
    self.menu1.heightOfRows = 50;
    self.menu1.gutter = 5;
    self.menu1.resilient = YES;
    [self.view addSubview:self.menu1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)createMutableArray:(NSArray *)array
{
    return [NSMutableArray arrayWithArray:array];
}

- (IBAction)didTapDone:(id)sender {
    [AddActViewController addActWithName:self.userActName.text
              withPoints:1
      inCategoryWithName:self.name];
}

+ (Act *)addActWithName:(NSString *)name
            withPoints:(NSInteger)points
    inCategoryWithName:(NSString *)categoryName {
    Act *actToBeAdded = [Act new];
    actToBeAdded.actName = name;
    actToBeAdded.pointsWorth = points;
    actToBeAdded.category = categoryName;
    
    [actToBeAdded saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (error)
            NSLog(@"error saving user act");
    }];
    
    // Adds new act to the its Act Category on Parse
    ActCategory *actCat = [ActCategory fetchCategoryOfName:categoryName];
    NSMutableArray *actCatMutable = [actCat.acts mutableCopy];
    [actCatMutable addObject:actToBeAdded];
    NSArray *array = [actCatMutable copy];
    actCat.acts = array;
    
    // Updates Act Object
    [actToBeAdded saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error)
            NSLog(@"%@", error.localizedDescription);
    }];
    // Updates Category Object
    [actCat saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (error)
            NSLog(@"error saving user act to category");
    }];
    
    return actToBeAdded;
}

- (void)dropDownMenu:(CCDropDownMenu *)dropDownMenu didSelectRowAtIndex:(NSInteger)index {
    NSString *dropdownCategory = ((ManaDropDownMenu *)dropDownMenu).title;
    self.name = dropdownCategory;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
