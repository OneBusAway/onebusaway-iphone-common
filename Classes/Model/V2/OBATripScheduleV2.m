#import "OBATripScheduleV2.h"
#import "OBACommon.h"


@implementation OBATripScheduleV2

@synthesize timeZone;
@synthesize stopTimes;
@synthesize frequency;
@synthesize previousTripId;
@synthesize nextTripId;

- (void) dealloc {
    self.timeZone = nil;
    self.stopTimes = nil;
    self.frequency = nil;
    self.previousTripId = nil;
    self.nextTripId = nil;
    [super dealloc];    
}

- (OBATripV2*) previousTrip {
	OBAReferencesV2 * refs = self.references;
	return [refs getTripForId:self.previousTripId];
}

- (OBATripV2*) nextTrip {
	OBAReferencesV2 * refs = self.references;
	return [refs getTripForId:self.nextTripId];
}


@end
