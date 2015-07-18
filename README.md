# ProgressController
ProgressController is a class designed for simplify the implementation of ProgressView with iOS style layout.
Simply assign the title text, number of tatal tasks and number of completed tasks, 
and it will performs iOS 7 (and on) style visual outlook to the users.

ProgressController perfroms transparent background in iOS 7 and blur effect in iOS 8(and on), 
also perform visual effect like motion effect, just like UIAlertController in iOS 7 and on.

# ARC Compatibility
ProgressController requires ARC. If you wish to use ProgressController in a non-ARC project, just add the -fobjc-arc compiler flag to the ProgressController.m class. To do this, go to the BUild Phases tab in your target settings, open the Compile Sources group, double-click ProgressController.m in the list and type -fobjc-arc into the popover.

# Examples
![Imgur](http://i.imgur.com/3AVEysn.jpg)

# Properties
Total number of tasks, defaults to 0.

	@property (assign, nonatomic) NSUInteger numberOfTasks;
	
Number of completed tasks, defaults to 0.

	@property (assign, nonatomic) NSUInteger completedTasks;
	
	
# Methods
Initiate with title text. 
 
	- (instancetype)initWIthTitle:(NSString *)title;

Show in provided view with completeHander if any. 

	- (void)presentInView:(UIView *)presentingView completion:(void(^)(void))completion;

Dismiss ProgressController.

	- (void)dismiss;
