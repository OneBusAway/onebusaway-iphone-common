#import "OBAHasReferencesV2.h"
#import "OBATransitLegV2.h"
#import "OBAStreetLegV2.h"


@interface OBALegV2 : OBAHasReferencesV2 {
    NSMutableArray * _streetLegs;
}

@property (nonatomic,retain) NSDate * startTime;
@property (nonatomic,retain) NSDate * endTime;
@property (nonatomic,retain) NSString * mode;
@property (nonatomic) double distance;

@property (nonatomic,retain) OBATransitLegV2 * transitLeg;
@property (nonatomic,readonly) NSArray * streetLegs;

- (void) addStreetLeg:(OBAStreetLegV2*)streetLeg;

@end
