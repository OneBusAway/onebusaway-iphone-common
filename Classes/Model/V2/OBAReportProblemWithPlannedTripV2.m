#import "OBAReportProblemWithPlannedTripV2.h"


@implementation OBAReportProblemWithPlannedTripV2

@synthesize fromLocation;
@synthesize toLocation;
@synthesize time;
@synthesize arriveBy;
@synthesize data;
@synthesize userComment;
@synthesize userLocation;

- (void) dealloc {
    self.fromLocation = nil;
    self.toLocation = nil;
    self.time = nil;
    self.data = nil;
    self.userComment = nil;
    self.userLocation = nil;
    [super dealloc];
}

@end
