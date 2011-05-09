#import "OBAMapRegionManager.h"
#import "OBASphericalGeometryLibrary.h"
#import "OBALogger.h"


static const double kMinRegionDeltaToDetectUserDrag = 50;
static const double kRegionChangeRequestsTimeToLive = 3.0;


typedef enum  {
    OBARegionChangeRequestTypeUser=0,
    OBARegionChangeRequestTypeProgramatic=1
} OBARegionChangeRequestType;


@interface OBARegionChangeRequest : NSObject
{
    NSDate * _timestamp;
    OBARegionChangeRequestType _type;
    MKCoordinateRegion _region;
}

- (id) initWithRegion:(MKCoordinateRegion)region type:(OBARegionChangeRequestType)type;
- (double) compareRegion:(MKCoordinateRegion)region;

@property (nonatomic,readonly) OBARegionChangeRequestType type;
@property (nonatomic,readonly) MKCoordinateRegion region;
@property (nonatomic,readonly) NSDate * timestamp;

@end



@interface OBAMapRegionManager (Private)

- (void) setMapRegion:(MKCoordinateRegion)region requestType:(OBARegionChangeRequestType)requestType;
- (void) setMapRegionWithRequest:(OBARegionChangeRequest*)request;
- (OBARegionChangeRequest*) getBestRegionChangeRequestForRegion:(MKCoordinateRegion)region;

@end


@implementation OBAMapRegionManager

@synthesize lastRegionChangeWasProgramatic = _lastRegionChangeWasProgramatic;

- (id) initWithMapView:(MKMapView*)mapView {
    self = [super init];
    if (self) {
        _mapView = [mapView retain];
        _lastRegionChangeWasProgramatic = FALSE;
        _currentlyChangingRegion = FALSE;
        _pendingRegionChangeRequest = nil;
        _appliedRegionChangeRequests = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) dealloc {
    [_mapView release];
    [_pendingRegionChangeRequest release];
    [_appliedRegionChangeRequests release];
    [super dealloc];
}

- (void) setRegion:(MKCoordinateRegion)region {
    [self setMapRegion:region requestType:OBARegionChangeRequestTypeProgramatic];
}

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
    _currentlyChangingRegion = TRUE;
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    
    _currentlyChangingRegion = FALSE;
    
    /**
     * We need to figure out if this region change came from the user dragging the map                                                                                                                                         
     * or from an actual programatic request we instigated.  The easiest way to tell is to                                                                                                                                                
     * keep a list of all our applied programatic region changes and compare them against
     * the actual map region change.  When the actual map region change doesn't match any
     * of our applied requests, we assume it must have been from a user zoom or pan.
     */
    MKCoordinateRegion region = _mapView.region;
    OBARegionChangeRequestType type = OBARegionChangeRequestTypeUser;
    
    //OBALogDebug(@"=== regionDidChangeAnimated: requests=%d",[_appliedRegionChangeRequests count]);
    //OBALogDebug(@"region=%@", [OBASphericalGeometryLibrary regionAsString:region]);
    
    OBARegionChangeRequest * request = [self getBestRegionChangeRequestForRegion:region];
    if( request ) {
        double score = [request compareRegion:region];
        //OBALogDebug(@"regionDidChangeAnimated: score=%f", score);
        //OBALogDebug(@"subregion=%@", [OBASphericalGeometryLibrary regionAsString:request.region]);
        if( score < kMinRegionDeltaToDetectUserDrag )
            type = request.type;
    }
    
    _lastRegionChangeWasProgramatic = (type == OBARegionChangeRequestTypeProgramatic);
    //OBALogDebug(@"regionDidChangeAnimated: setting _lastRegionChangeWasProgramatic to %d", _lastRegionChangeWasProgramatic);
    
    if( _lastRegionChangeWasProgramatic && _pendingRegionChangeRequest ) {
        //OBALogDebug(@"applying pending reqest");
        [self setMapRegionWithRequest:_pendingRegionChangeRequest];
    }
    
    _pendingRegionChangeRequest = [NSObject releaseOld:_pendingRegionChangeRequest retainNew:nil];
}

@end



@implementation OBAMapRegionManager (Private)

- (void) setMapRegion:(MKCoordinateRegion)region requestType:(OBARegionChangeRequestType)requestType {
    
    OBARegionChangeRequest * request = [[OBARegionChangeRequest alloc] initWithRegion:region type:requestType];
    [self setMapRegionWithRequest:request];
    [request release];
}

- (void) setMapRegionWithRequest:(OBARegionChangeRequest*)request {
    
    //OBALogDebug(@"setMapRegion: requestType=%d region=%@",request.type,[OBASphericalGeometryLibrary regionAsString:request.region]);
    
    /**                                                                                                                                                                                                                        
     * If we are currently in the process of changing the map region, we save the region change request as pending.                                                                                                            
     * Otherwise, we apply the region change.                                                                                                                                                                                  
     */
    if ( _currentlyChangingRegion ) {
        //OBALogDebug(@"saving pending request");
        _pendingRegionChangeRequest = [NSObject releaseOld:_pendingRegionChangeRequest retainNew:request];
    }
    else {
        [_appliedRegionChangeRequests addObject:request];
        [_mapView setRegion:request.region animated:TRUE];
    }
}

- (OBARegionChangeRequest*) getBestRegionChangeRequestForRegion:(MKCoordinateRegion)region {
    
    NSMutableArray * requests = [[NSMutableArray alloc] init];
    OBARegionChangeRequest * bestRequest = nil;
    double bestScore = 0;
    
	NSDate * now = [NSDate date];
    
	for( OBARegionChangeRequest * request in  _appliedRegionChangeRequests ) {
        
        NSTimeInterval interval = [now timeIntervalSinceDate:request.timestamp];
        
        if( interval <= kRegionChangeRequestsTimeToLive ) {
            [requests addObject:request];
            double score = [request compareRegion:region];
            if( bestRequest == nil || score < bestScore)  {
                bestRequest = request;
                bestScore = score;
            }
        }
    }
    
    _appliedRegionChangeRequests = [NSObject releaseOld:_appliedRegionChangeRequests retainNew:requests];
    
    return bestRequest;
}

@end



@implementation OBARegionChangeRequest

@synthesize type = _type;
@synthesize region = _region;
@synthesize timestamp = _timestamp;

- (id) initWithRegion:(MKCoordinateRegion)region type:(OBARegionChangeRequestType)type {
    
    self = [super init];
    
    if( self ) {
        _region = region;
		_type = type;
        _timestamp = [[NSDate alloc] init];
    }
    return self;
}

-(void) dealloc {
    [_timestamp release];
	[super dealloc];
}

- (double) compareRegion:(MKCoordinateRegion)region {
	return [OBASphericalGeometryLibrary getDistanceFromRegion:_region toRegion:region];
}

@end
