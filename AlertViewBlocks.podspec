Pod::Spec.new do |s|
  s.name         	= 'AlertViewBlocks'
  s.version      	= '1.0.2'
  s.platform        = :ios, '6.0'
  s.summary      	= 'UIAlertView using blocks'
  s.description		= 'Makes really easy to use AlertView without having a instance variable.'
  s.homepage     	= 'https://github.com/priore/AlertViewBlocks.git'
  s.social_media_url	= 'https://twitter.com/danilopriore'
  s.license      	= { :type => 'GNU License', :file => 'LICENSE' }
  s.author       	= { 'Danilo Priore' => 'support@prioregroup.com' }
  s.source 			= { git: 'https://github.com/priore/AlertViewBlocks.git', :tag => "v#{s.version}" }
  s.source_files 	= 'AlertViewBlocks/*'
  s.requires_arc 	= true
end
