#import "OBAItineraryV2.h"


@implementation OBAItineraryV2

@synthesize startTime;
@synthesize  endTime;
@synthesize legs = _legs;

- (id) init {
    self = [super init];
    if (self) { 
        _legs = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void) dealloc {
    
    self.startTime = nil;
    self.endTime = nil;
    
    [_legs release];
    _legs = nil;
    
    [super dealloc];
}

- (void) addLeg:(OBALegV2*)leg {
    [_legs addObject:leg];
}

@end
