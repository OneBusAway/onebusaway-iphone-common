#import "OBAStreetLegV2.h"


@implementation OBAStreetLegV2

@synthesize streetName;
@synthesize path;
@synthesize distance;

- (void) dealloc {
    self.streetName = nil;
    self.path = nil;
    [super dealloc];
}

@end
