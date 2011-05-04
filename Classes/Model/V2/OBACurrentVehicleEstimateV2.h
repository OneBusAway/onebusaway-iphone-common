#import "OBATripStatusV2.h"


@interface OBACurrentVehicleEstimateV2 : NSObject {
    
}

@property (nonatomic) double probability;
@property (nonatomic,retain) OBATripStatusV2 * tripStatus;
@property (nonatomic,retain) NSString * debug;

@end
