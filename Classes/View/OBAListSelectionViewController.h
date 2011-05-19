@interface OBAListSelectionViewController : UITableViewController {
	NSArray * _values;
	NSIndexPath * _checkedItem;
	id _target;
	SEL _action;
}

@property (nonatomic,retain) NSIndexPath * checkedItem;
@property (nonatomic,assign) id target;
@property (nonatomic) SEL action;

@property (nonatomic) BOOL exitOnSelection;

- (id)initWithValues:(NSArray*)values selectedIndex:(NSIndexPath*)selectedIndex;


@end
