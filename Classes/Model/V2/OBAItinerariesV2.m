#import "OBAItinerariesV2.h"


@implementation OBAItinerariesV2

@synthesize itineraries = _itineraries;

-(id)init {
    self = [super init];
    if( self ) {
        _itineraries = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)dealloc {
    [_itineraries release];
    [super dealloc];
}

-(void) addItinerary:(OBAItineraryV2*)itinerary {
    [_itineraries addObject:itinerary];
}

@end
