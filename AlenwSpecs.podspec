Pod::Spec.new do |s|
	s.name = 'AlenwSpecs'
	s.version = '1.0.0'
	s.license = 'MIT'
	s.summary = 'AlenwSpecs use to be update common Class'
	s.description = <<-DESC
	    AlenwSpecs use to be update common Class,
	    this is a pravite framework.
	DESC
	s.homepage = 'https://github.com/Alenw'
	s.author = { 'Alenw' => 'https://github.com/Alenw' }
	s.source = { :path => '~/Desktop/AlenwSpecs',:tag => '1.0.0' }
	s.platform = :ios,"7.0"
	s.requires_arc = true

   s.subspec 'AdView' do |ss|
#	ss.dependency   'AlenwSpecs/Tools'
	ss.dependency   'SDWebImage','~>3.7.3'
	ss.source_files = 'AdView/*.{h,m}'
   end
   s.subspec 'Commom' do |ss|
#	ss.dependency   'SDWebImage','~>3.7.3'
	ss.source_files = 'Common/*.{h,m}'
#	ss.dependency   'AlenwSpecs/Tools'
	ss.ios.framework = 'WebKit'
   end
   s.subspec 'Tools' do |ss|
        ss.source_files = 'Tools/*.{h,m}'
	ss.vendored_frameworks = 'Tools/*.framework'
	ss.resource= 'Tools/AwAlertViewlib.bundle'
	ss.pod_target_xcconfig = { 'OTHER_LDFAGS' => '-all_load'}
   end
end
