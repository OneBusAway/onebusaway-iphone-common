#import "OBAHasReferencesV2.h"


@implementation OBAHasReferencesV2

@synthesize references = _references;

- (id) initWithReferences:(OBAReferencesV2*)refs {
    self = [super init];
	if( self ) {
		self.references = refs;
	}
	return self;
}

- (void) dealloc {
	[_references release];
	[super dealloc];
}

@end
