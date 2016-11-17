Pod::Spec.new do |s|
  s.name         			= 'AlertViewBlocks'
  s.version      			= '1.1.0'
  s.summary      			= 'Makes really easy to use AlertView without having a instance variable for iOS and tvOS'
  s.license      			= { :type => 'GNU License', :file => 'LICENSE' }
  s.authors 				= { 'Danilo Priore' => 'support@prioregroup.com' }
  s.homepage     			= 'https://github.com/priore/AlertViewBlocks.git'
  s.social_media_url		= 'https://twitter.com/danilopriore'
  s.source 					= { git: 'https://github.com/priore/AlertViewBlocks.git', :tag => "v#{s.version}" }
  s.ios.deployment_target 	= '8.0'
  s.tvos.deployment_target 	= '9.0'
  s.source_files 			= 'AlertViewBlocks/*'
  s.requires_arc 			= true
end
