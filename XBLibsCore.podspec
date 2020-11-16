
Pod::Spec.new do |s|

    s.name         = "XBLibsCore"
    s.version      = "0.0.4"
    s.summary      = "A short description of XBLibsCore."
    s.homepage     = "https://github.com/ZB0106/XBLibsCore"
    #s.license      = "MIT (example)"
    s.author             = { "kdzebing" => "rongzebing@gokudian.com" }
    s.source       = { :git => "https://github.com/ZB0106/XBLibsCore", :tag => "#{s.version}" }
    s.source_files  = "Sources/**/*.swift"
    
    s.platform     = :ios, "9.0"
    s.requires_arc = true
    s.frameworks = 'UIKit', 'Foundation'
    s.swift_versions = ['5.1', '5.2', '5.3']
#由于需要依赖的三方库都是静态库,如果这里不指定本库为静态库,则cocoapods中默认会编译成动态库,而此动态库中依赖了静态库,会导致编译失败, 因此这里需要指定编译成静态库
    s.static_framework = true
    
    
    s.subspec 'XBListViewManager' do |xb|
        xb.source_files = 'Sources/XBListViewManager/*/*.swift'
        xb.frameworks = 'UIKit', 'Foundation'
        xb.dependency 'MJRefresh'
        xb.dependency 'SnapKit'
    end
    
end
