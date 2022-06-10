version = "1.0.3"

Pod::Spec.new do |s|
  s.name         = 'CollectionViewCenteredFlowLayout'
  s.version      = version
  s.summary      = 'A layout for UICollectionView that aligns the cells to the center'
  s.description  = <<-DESC
                   A `UICollectionViewLayout` implementation that aligns the cells to the center.

                   It uses `UICollectionViewFlowLayout` under the hood.
                   DESC
  s.homepage     = 'https://github.com/coeur/CollectionViewCenteredFlowLayout'
  s.screenshots  = 'https://raw.githubusercontent.com/coeur/CollectionViewCenteredFlowLayout/main/screenshot.png'
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.authors      = { 'Antoine Cœur' => '' }
  s.social_media_url   = 'https://twitter.com/adigitalknight'
  s.platform     = :ios, '8.0'
  s.source       = { :git => 'https://github.com/coeur/CollectionViewCenteredFlowLayout.git', :tag => version }
  s.source_files  = 'CollectionViewCenteredFlowLayout/*.swift'
end
