//
//  WalkthroughViewController.m
//  rak
//
//  Created by Haley Zeng on 8/3/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import "WalkthroughViewController.h"
#import "WalkthroughContentViewController.h"

@interface WalkthroughViewController () <UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageInfoStrings;
@property (strong, nonatomic) NSArray *pageImageNames;

@end

@implementation WalkthroughViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageInfoStrings = @[@"Get ideas for fun acts of kindness you can do every day", @"Complete acts of kindness to level up and earn achievements", @"Read and share stories of how kindness has touched your life"];
    self.pageImageNames = @[@"catalogueSS", @"profileSS", @"timelineSS"];
    
    
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    WalkthroughContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 60);
    
    [self addChildViewController: self.pageViewController];
    [self.view addSubview: self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = ((WalkthroughContentViewController *) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((WalkthroughContentViewController *) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageInfoStrings count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (WalkthroughContentViewController *)viewControllerAtIndex:(NSUInteger)index {
    if (index >= [self.pageInfoStrings count]) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    WalkthroughContentViewController *walkthroughContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WalkthroughContentController"];
    walkthroughContentViewController.imageName = self.pageImageNames[index];
    walkthroughContentViewController.infoString = self.pageInfoStrings[index];
    walkthroughContentViewController.pageIndex = index;
    
    return walkthroughContentViewController;
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return [self.pageInfoStrings count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTapGotIt:(id)sender {
    [self performSegueWithIdentifier:@"homeSegue" sender:nil];
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
