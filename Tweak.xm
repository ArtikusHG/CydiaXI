@interface CyteWebViewController
- (void)reloadButtonClicked;
@end
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
/*
This is going to be the code to change the home page website
When I get the website done, I'll uncomment that
%hook UIWebBrowserView
#define cyHomeKitURL @"http://cydia.saurik.com"
#define home @"cydia.saurik.com/ui/ios~iphone/1.1/home"
#define homeXL @"cydia.saurik.com/ui/ios~ipad/1.1/home"
- (void)loadRequest:(NSURLRequest *)request {
if ([request.URL.absoluteString rangeOfString:home].length != 0 || [request.URL.absoluteString rangeOfString:homeXL].length != 0) {
NSURLRequest *cyHomeRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:cyHomeKitURL]];
%orig(cyHomeRequest);
}
else {
%orig;
}
}
%end
This is a workaroundish code, it reloads ONCE with the home page, but goes on loop with tweak pages :/
%hook CyteWebViewController
- (void)_setViewportWidth {
%orig;
[self reloadButtonClicked];
}
%end
*/
%hook UITabBarItem
- (id)initWithTitle:(id)arg1 image:(id)arg2 selectedImage:(id)arg3 {
if([arg1 isEqual:@"Cydia"]) {
return %orig(@"Cydia",[UIImage imageNamed:@"Cydia.png"],[UIImage imageNamed:@"CydiaSEL.png"]);
} else if([arg1 isEqual:@"Sources"]) {
return %orig(@"Sources",[UIImage imageNamed:@"Sources.png"],[UIImage imageNamed:@"SourcesSEL.png"]);
} else if([arg1 isEqual:@"Changes"]) {
return %orig(@"Changes",[UIImage imageNamed:@"Changes.png"],[UIImage imageNamed:@"ChangesSEL.png"]);
} else if([arg1 isEqual:@"Installed"]) {
return %orig(@"Installed",[UIImage imageNamed:@"Installed.png"],[UIImage imageNamed:@"InstalledSEL.png"]);
} else if([arg1 isEqual:@"Search"]) {
return %orig(@"Search",[UIImage imageNamed:@"Search.png"],[UIImage imageNamed:@"SearchSEL.png"]);
} else {
return %orig;
}
}
%end
