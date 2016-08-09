#import "../PS.h"

@interface _UIKeyboardTextSelectionGestureController : NSObject
- (void)addTwoFingerTextSelectionGesturesToView:(id)view;
- (void)addOneFingerTextSelectionGesturesToView:(id)view;
@end

BOOL enabled = YES;
BOOL something = YES;

BOOL addTwoFinger = NO;
BOOL override = NO;

%hook UIDevice

- (UIUserInterfaceIdiom)userInterfaceIdiom
{
	return override ? UIUserInterfaceIdiomPad : %orig;
}

%end

%hook _UIKeyboardTextSelectionGestureController

- (void)configureTwoFingerPanGestureRecognizer:(id)arg1
{
	override = enabled && something;
	%orig;
	override = NO;
}

- (void)configureTwoFingerTapGestureRecognizer:(id)arg1
{
	override = enabled && something;
	%orig;
	override = NO;
}

// This method is always invoked in -[UIKeyboardImpl updateLayout], but iPad only in case of two finger
// So do it here
- (void)addOneFingerTextSelectionGesturesToView:(id)view
{
	if (addTwoFinger)
		[self addTwoFingerTextSelectionGesturesToView:view];
	%orig;
}

%end

%hook UIKeyboardImpl

- (void)updateLayout
{
	addTwoFinger = enabled;
	%orig;
	addTwoFinger = NO;
}

%end

%hook UIKeyboardLayout

- (void)touchesBegan:(id)arg1 withEvent:(id)arg2
{
	override = enabled;
	%orig;
	override = NO;
}

%end

%hook UITextInteractionAssistant

- (void)addKeyboardTextSelectionGestureRecognizersToView:(id)arg1
{
	override = enabled;
	%orig;
	override = NO;
}

%end