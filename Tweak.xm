BOOL enabled = YES;
CGFloat offsety = 20;
CGFloat offsetx = 20;
@interface WATodayPadView : UIView
- (id)initWithFrame:(CGRect)frame;
@property (nonatomic,retain) UIView * locationLabel;
@property (nonatomic,retain) UIView * conditionsLabel;
@property (nonatomic,retain) UIView * conditionsImageView;
@property (nonatomic,retain) UIView * temperatureLabel; 
@end
%ctor
{
	NSLog(@"Loading SpotWeather!");
}
%hook SBSearchEtceteraIsolatedViewController
- (_Bool)_deviceSupportsWeatherDisplay
{
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
			_center.y =  (self.conditionsLabel.center.y + offsety);
			_center.x =  (self.conditionsLabel.center.x + offsetx);
			self.conditionsLabel.center = _center;
		}
		if (self.locationLabel) 
		{
			CGPoint _center = self.locationLabel.center;
			_center.y =  (self.locationLabel.center.y + offsety);
			_center.x =  (self.locationLabel.center.x + offsetx);
			self.locationLabel.center = _center;
		}
		if(self.conditionsImageView)
		{
			CGPoint _center = self.conditionsImageView.center;
			_center.y =  (self.conditionsImageView.center.y + offsety);
			_center.x =  (self.conditionsImageView.center.x + offsetx);
			self.conditionsImageView.center = _center;
		}
		if(self.temperatureLabel)
		{
			CGPoint _center = self.temperatureLabel.center;
			_center.y =  (self.temperatureLabel.center.y + offsety);
			_center.x =  (self.temperatureLabel.center.x + offsetx);
			self.temperatureLabel.center = _center;
		}
	}
}
%end
