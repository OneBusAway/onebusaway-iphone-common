#import "OBAPlacemarks.h"


@implementation OBAPlacemarks

@synthesize placemarks = _placemarks;
@synthesize attributions = _attributions;

- (id) init {
    self = [super init];
    if( self ) {
        _placemarks = [[NSMutableArray alloc] init];
        _attributions = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) dealloc {
    OBA_RELEASE_SAFELY(_placemarks);
    OBA_RELEASE_SAFELY(_attributions);
    [super dealloc];
}

- (void) addPlacemark:(OBAPlacemark*)placemark {
    [_placemarks addObject:placemark];
}

- (void) addAttribution:(NSString*)attribution {
    [_attributions addObject:attribution];
}

@end
