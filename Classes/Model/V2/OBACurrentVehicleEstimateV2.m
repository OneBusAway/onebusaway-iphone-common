#import "OBACurrentVehicleEstimateV2.h"


@implementation OBACurrentVehicleEstimateV2

- (void) dealloc {
    self.tripStatus = nil;
    self.debug = nil;
    [super dealloc];
}

@synthesize probability;
@synthesize tripStatus;
@synthesize debug;

@end
