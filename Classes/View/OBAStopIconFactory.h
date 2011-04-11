#import "OBAStopV2.h"
#import "OBARouteV2.h"


@interface OBAStopIconFactory : NSObject {
	NSMutableDictionary * _stopIcons;
	UIImage * _defaultStopIcon;
}

- (UIImage*) getIconForStop:(OBAStopV2*)stop;
- (UIImage*) getModeIconForRoute:(OBARouteV2*)route;

@end
