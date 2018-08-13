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
- (IBAction)didTapOut:(id)sender;

@end

@implementation AddActViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self menuSetup];
}

- (void)menuSetup {
    CGRect frame = CGRectMake((CGRectGetWidth(self.view.frame)-240)/2, 45, 240, 37);
    UIColor *backgroundColor = [UIColor colorWithRed:(247/255.0) green:(247/255.0) blue:(247/255.0) alpha:1.0];
   // UIColor *palleteGreen = [UIColor colorWithRed:(6/255.0) green:(214/255.0) blue:(160/255.0) alpha:1.0];
    
    UIColor *darkBlue = [UIColor colorWithRed:(21/255.0) green:(59/255.0) blue:(91/255.0) alpha:1.0];
    
    self.menu1 = [[ManaDropDownMenu alloc] initWithFrame:frame title:@"Choose a category"];
    self.menu1.delegate = self;
    self.menu1.numberOfRows = 6;
    self.menu1.textOfRows = @[@"Local Needs", @"Relationship", @"Friends", @"Work", @"Community", @"Family"];
    self.menu1.colorOfRows = @[backgroundColor, backgroundColor, backgroundColor, backgroundColor, backgroundColor, backgroundColor];
    self.menu1.heightOfRows = 50;
    self.menu1.activeColor = darkBlue;
    [self.view addSubview:self.menu1];
}

- (NSMutableArray *)createMutableArray:(NSArray *)array
{
    return [NSMutableArray arrayWithArray:array];
}

- (IBAction)didTapDone:(id)sender {
    [AddActViewController addActWithName:self.userActName.text
              withPoints:1
      inCategoryWithName:self.name];
    [self.navigationController popViewControllerAnimated:YES];
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

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self view] endEditing:YES];
}

- (void)dropDownMenu:(CCDropDownMenu *)dropDownMenu didSelectRowAtIndex:(NSInteger)index {
    NSString *dropdownCategory = ((ManaDropDownMenu *)dropDownMenu).title;
    self.name = dropdownCategory;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
