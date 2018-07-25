#import "DateFunctions.h"

@implementation DateFunctions

+ (NSDate *)getYesterday {
    NSDate *now = [NSDate date];
    int daysToAdd = -1;
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:daysToAdd];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDate *yesterday = [gregorian dateByAddingComponents:components toDate:now options:0];
    
    NSDateComponents *dateComponents = [gregorian components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:yesterday];
    
    yesterday = [gregorian dateFromComponents:dateComponents];
    
    return yesterday;
}

+ (NSDate *)getToday {
    NSDate *now = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *dateComponents = [gregorian components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:now];
    
    NSDate *today = [gregorian dateFromComponents:dateComponents];
    
    return today;
}

@end
