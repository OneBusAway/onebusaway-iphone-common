#import "OBAHasReferencesV2.h"
#import "OBATripV2.h"
#import "OBAStopV2.h"
#import "OBAFrequencyV2.h"


@interface OBATransitLegV2 : OBAHasReferencesV2 {
    
}

@property (nonatomic,retain) NSString * tripId;
@property (nonatomic) long long serviceDate;
@property (nonatomic,retain) NSString * vehicleId;
@property (nonatomic,retain) OBAFrequencyV2 * frequency;
@property (nonatomic,retain) NSString * fromStopId;
@property (nonatomic) NSInteger fromStopSequence;
@property (nonatomic,retain) NSString * toStopId;
@property (nonatomic) NSInteger toStopSequence;
@property (nonatomic,retain) NSString * tripHeadsign;
@property (nonatomic,retain) NSString * routeShortName;
@property (nonatomic,retain) NSString * routeLongName;
@property (nonatomic,retain) NSString * path;
@property (nonatomic) long long scheduledDepartureTime;
@property (nonatomic) long long predictedDepartureTime;
@property (nonatomic,readonly) long long bestDepartureTime;
@property (nonatomic) long long scheduledArrivalTime;
@property (nonatomic) long long predictedArrivalTime;
@property (nonatomic,readonly) long long bestArrivalTime;

@property (nonatomic,readonly) OBATripV2 * trip;
@property (nonatomic,readonly) OBAStopV2 * fromStop;
@property (nonatomic,readonly) OBAStopV2 * toStop;


@end
