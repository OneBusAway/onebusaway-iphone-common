@interface OBAStopAccessEventV2 : NSObject <NSCoding> {

}

- (id) initWithCoder:(NSCoder*)coder;

@property (nonatomic,retain) NSString * title;
@property (nonatomic,retain) NSString * subtitle;
@property (nonatomic, retain) NSArray * stopIds;

@end
