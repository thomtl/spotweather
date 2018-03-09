#include "Tweak.h"

static BOOL enabled = YES;
static BOOL enableConditionImage = YES;
static BOOL enableConditionLabel = NO;
static BOOL enableLocationLabel = NO;
static BOOL enableTemperatureLabel = YES;


static CGFloat offsetY = 20;
static CGFloat offsetX = 0;

%ctor
{
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)RespringDevice, CFSTR("com.thomtl.spotweathersettings/respring"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)LoadSettings, CFSTR("com.thomtl.spotweathersettings/settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
	LoadSettings();
	NSLog(@"Loading SpotWeather!");
}

static void RespringDevice()
{
	[[%c(FBSystemService) sharedInstance] exitAndRelaunch:YES];
}

static void LoadSettings()
{
    NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.thomtl.spotweathersettings.plist"];
    if(prefs)
    {
        enabled = [[prefs objectForKey:@"enabled"] boolValue];
	enableConditionImage = [[prefs objectForKey:@"enableconditionview"] boolValue];
	enableConditionLabel = [[prefs objectForKey:@"enableconditionlabel"] boolValue];
	enableLocationLabel = [[prefs objectForKey:@"enablelocationlabel"] boolValue];
	enableTemperatureLabel = [[prefs objectForKey:@"enabletemperaturelabel"] boolValue];
	offsetX = (CGFloat)[[prefs objectForKey:@"OffsetX"] doubleValue];
	offsetY = (CGFloat)[[prefs objectForKey:@"OffsetY"] doubleValue];
    }
    [prefs release];
}

%hook SBSearchEtceteraIsolatedViewController
- (_Bool)_deviceSupportsWeatherDisplay
{
	LoadSettings();
	if(enabled == YES)
	{
		return YES;
	} else {
		return %orig;
	}
}
%end
%hook WATodayPadView
- (void)layoutSubviews {
	%orig;
	if(offsetY == 0 && offsetX == 0)
	{
		return;
	}
	if(enabled == YES)
	{
		if (self.conditionsLabel) 
		{
			CGPoint _center = self.conditionsLabel.center;
			_center.y =  (self.conditionsLabel.center.y + offsetY);
			_center.x =  (self.conditionsLabel.center.x + offsetX);
			self.conditionsLabel.center = _center;
			self.conditionsLabel.hidden = !enableConditionLabel;
		}
		if (self.locationLabel) 
		{
			CGPoint _center = self.locationLabel.center;
			_center.y =  (self.locationLabel.center.y + offsetY);
			_center.x =  (self.locationLabel.center.x + offsetX);
			self.locationLabel.center = _center;
			self.locationLabel.hidden = !enableLocationLabel;
		}
		if(self.conditionsImageView)
		{
			CGPoint _center = self.conditionsImageView.center;
			_center.y =  (self.conditionsImageView.center.y + offsetY);
			_center.x =  (self.conditionsImageView.center.x + offsetX);
			self.conditionsImageView.center = _center;
			self.conditionsImageView.hidden = !enableConditionImage;
		}
		if(self.temperatureLabel)
		{
			CGPoint _center = self.temperatureLabel.center;
			_center.y =  (self.temperatureLabel.center.y + offsetY);
			_center.x =  (self.temperatureLabel.center.x + offsetX);
			self.temperatureLabel.center = _center;
			self.temperatureLabel.hidden = !enableTemperatureLabel;
		}
	}
}
%end
