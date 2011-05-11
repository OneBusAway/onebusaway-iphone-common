#import "OBASituationConsequenceV2.h"


@implementation OBASituationConsequenceV2

@synthesize condition;
@synthesize diversionPath;

- (void) dealloc {
	self.condition = nil;
	self.diversionPath = nil;
	[super dealloc];
}

@end
