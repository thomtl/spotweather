#include "Tweak.h"

static BOOL enabled = YES;

static CGFloat offsetY = 20;
static CGFloat offsetX = 0;

%ctor
{
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)LoadSettings, CFSTR("com.thomtl.spotweathersettings/settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
	LoadSettings();
	NSLog(@"Loading SpotWeather!");
}

static void LoadSettings()
{
    NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.thomtl.spotweathersettings.plist"];
    if(prefs)
    {
        enabled = [[prefs objectForKey:@"enabled"] boolValue];
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
	if(enabled == YES)
	{
		if (self.conditionsLabel) 
		{
			CGPoint _center = self.conditionsLabel.center;
			_center.y =  (self.conditionsLabel.center.y + offsetY);
			_center.x =  (self.conditionsLabel.center.x + offsetX);
			self.conditionsLabel.center = _center;
		}
		if (self.locationLabel) 
		{
			CGPoint _center = self.locationLabel.center;
			_center.y =  (self.locationLabel.center.y + offsetY);
			_center.x =  (self.locationLabel.center.x + offsetX);
			self.locationLabel.center = _center;
		}
		if(self.conditionsImageView)
		{
			CGPoint _center = self.conditionsImageView.center;
			_center.y =  (self.conditionsImageView.center.y + offsetY);
			_center.x =  (self.conditionsImageView.center.x + offsetX);
			self.conditionsImageView.center = _center;
		}
		if(self.temperatureLabel)
		{
			CGPoint _center = self.temperatureLabel.center;
			_center.y =  (self.temperatureLabel.center.y + offsetY);
			_center.x =  (self.temperatureLabel.center.x + offsetX);
			self.temperatureLabel.center = _center;
		}
	}
}
%end
