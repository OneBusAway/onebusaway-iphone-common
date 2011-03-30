#import "OBATransitLegV2.h"


@implementation OBATransitLegV2

@synthesize tripId;
@synthesize serviceDate;
@synthesize fromStopId;
@synthesize fromStopSequence;
@synthesize toStopId;
@synthesize toStopSequence;
@synthesize tripHeadsign;
@synthesize path;
@synthesize scheduledDepartureTime;
@synthesize predictedDepartureTime;
@synthesize scheduledArrivalTime;
@synthesize predictedArrivalTime;

- (OBATripV2*) trip {
    OBAReferencesV2 * refs = self.references;
    return [refs getTripForId:self.tripId];
}

- (OBAStopV2*) fromStop {
    OBAReferencesV2 * refs = self.references;
    return [refs getStopForId:self.fromStopId];
}

- (OBAStopV2*) toStop {
    OBAReferencesV2 * refs = self.references;
    return [refs getStopForId:self.toStopId];
}

@end
