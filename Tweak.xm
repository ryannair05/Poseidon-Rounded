#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)

// Enable home gestures
%hook BSPlatform
- (NSInteger)homeButtonType {
		return 2;
}
%end

// Hide home bar
%hook MTLumaDodgePillView
- (id)initWithFrame:(struct CGRect)arg1 {
	return NULL;
}
%end

// Hide Camera and Flashlight Button on Coversheet
%hook SBDashBoardQuickActionsViewController	
	-(BOOL)hasFlashlight{
		return NO;
		}
	-(BOOL)hasCamera{
		return NO;
}
%end

//FUgap, credit to smokin1337
%hook CCUIHeaderPocketView
-(CGRect)contentBounds{
             return CGRectMake (0,0,SCREEN_WIDTH,65);
  }
%end

%hook CCUIScrollView
-(void)setContentInset:(UIEdgeInsets)arg1 {
     arg1 = UIEdgeInsetsMake(50,0,0,0);
     %orig;
  }
%end

%hook _UIStatusBarVisualProvider_iOS
+ (Class)class {
	return NSClassFromString(@"_UIStatusBarVisualProvider_Split58"); 
}
%end

%hook UIStatusBar_Base
+ (Class)_implementationClass {
    return NSClassFromString(@"UIStatusBar_Modern");
}
+ (void)_setImplementationClass:(Class)arg1 {
    %orig(NSClassFromString(@"UIStatusBar_Modern"));
}
%end

%hook UIStatusBar
+ (CGFloat)heightForOrientation:(NSInteger)orientation {
		return %orig - 10;
	}
%end

//Thanks to NoisyFlake and his tweak ModernDock
%hook UITraitCollection
- (CGFloat)displayCornerRadius {
	return 19;
}
%end

%hook SBDockIconListView
+ (NSUInteger)maxIcons {
	return 5;
}
%end

%hook UIKeyboardImpl
+ (UIEdgeInsets)deviceSpecificPaddingForInterfaceOrientation:(long long)arg1 inputMode:(id)arg2 {
UIEdgeInsets orig = %orig;
		orig.bottom =  40;		
		return orig;
}
%end

@interface UIKeyboardDockView : UIView
@end

%hook UIKeyboardDockView
- (CGRect)bounds {
		CGRect bounds = %orig;
		bounds.size.height += 20;
		return bounds;
}

%end



