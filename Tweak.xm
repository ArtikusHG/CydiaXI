%hook CydiaLoadingViewController
-(void)loadView {
	%orig;
	UIView *xiView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
	xiView.backgroundColor = [UIColor whiteColor];
	UIImageView *logo =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logo.png"]];
	logo.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 60, [UIScreen mainScreen].bounds.size.height / 2 - 90, 120, 120);
	logo.layer.masksToBounds = YES;
	logo.layer.cornerRadius = 10;
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height / 2 + 60, [UIScreen mainScreen].bounds.size.width, 40)];
	label.text = @"Cydia";
	label.textAlignment = NSTextAlignmentCenter;
	[label setFont:[UIFont boldSystemFontOfSize:30]];
	[xiView addSubview:logo];
	[xiView addSubview:label];
	[[self view] addSubview:xiView];
}
%end
%hook UINavigationItemView
- (void)layoutSubviews {
	%orig;
	MSHookIvar<UILabel *>(self, "_label").frame = CGRectMake(-[UIScreen mainScreen].bounds.size.width / 2 + 40,-13,[UIScreen mainScreen].bounds.size.width,50);
	[MSHookIvar<UILabel *>(self, "_label") setFont:[UIFont boldSystemFontOfSize:40]];
	if([MSHookIvar<UILabel *>(self, "_label").text isEqual:@"Refreshing Data"]) {
		MSHookIvar<UILabel *>(self, "_label").text = @" Refreshing...";
	}
	if([MSHookIvar<UILabel *>(self, "_label").text isEqual:@"Updating Sources"]) {
		MSHookIvar<UILabel *>(self, "_label").text = @" Refreshing...";
	}
}
%end
%hook HomeController
-(id)leftButton {
	return nil;
}
%end
%hook ChangesController
- (void)setLeftBarButtonItem{}
%end
%hook UINavigationItem
- (void)_setBackButtonTitle:(id)arg1 lineBreakMode:(int)arg2 {
	%orig(nil,arg2);
}
- (id)backBarButtonItem {
	return nil;
}
- (id)backButtonTitle {
	return nil;
}
- (id)backButtonView {
	return nil;
}
%end
%hook UIButton
- (void)_setTitle:(id)arg1 forStates:(unsigned int)arg2 {
	if(![arg1 isEqual:@"Refresh"] && ![arg1 isEqual:@"Cancel"] && ![arg1 isEqual:@"Add"]) {
		%orig;
	}
}
%end
