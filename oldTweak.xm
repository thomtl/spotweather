CGFloat x = 71;
CGFloat y = 65;
CGFloat offset = 20;
@interface WATodayPadView : UIView
- (id)initWithFrame:(CGRect)frame;
@property (nonatomic,retain) UIView * locationLabel;
@property (nonatomic,retain) UIView * conditionsLabel;
@property (nonatomic,retain) UIView * conditionsImageView;
@property (nonatomic,retain) UIView * temperatureLabel; 
@end
%hook SBSearchEtceteraIsolatedViewController
- (_Bool)_deviceSupportsWeatherDisplay
{
	return YES;
}
%end
%hook WATodayPadView
- (void)layoutSubviews {
	%orig;
	CGFloat conLabelnew = self.conditionsLabel.center.y + offset;
	CGFloat locLabelnew = self.locationLabel.center.y + offset;
	CGFloat conImgviewnew = self.conditionsImageView.center.y + offset;
	CGFloat tempLabelnew = self.temperatureLabel.center.y + offset;
	if (self.conditionsLabel) {
		self.conditionsLabel.center.y = conLabelnew;
	}

	if (self.locationLabel) {
		self.locationLabel.center.y = locLabelnew;
	}
	if(self.conditionsImageView)
	{
		self.conditionsImageView.center.y = conImgviewnew;
	}
	if(self.temperatureLabel)
	{
		self.temperatureLabel.center.y = tempLabelnew;
	}

}
%end
