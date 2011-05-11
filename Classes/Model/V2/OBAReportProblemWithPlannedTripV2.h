@interface OBAReportProblemWithPlannedTripV2 : NSObject {
    
}

@property (nonatomic,retain) CLLocation * fromLocation;
@property (nonatomic,retain) CLLocation * toLocation;
@property (nonatomic,retain) NSDate * time;
@property (nonatomic) BOOL arriveBy;
@property (nonatomic,retain) NSString * data;
@property (nonatomic,retain) NSString * userComment;
@property (nonatomic,retain) CLLocation * userLocation;

@end
