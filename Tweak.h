@interface WATodayPadView : UIView
        @property (nonatomic,retain) UIView * locationLabel;
        @property (nonatomic,retain) UIView * conditionsLabel;
        @property (nonatomic,retain) UIView * conditionsImageView;
        @property (nonatomic,retain) UIView * temperatureLabel;
@end

@interface FBSystemService
	+(id)sharedInstance;
	-(void)exitAndRelaunch:(BOOL)arg1;
@end

static void LoadSettings();
static void RespringDevice();
