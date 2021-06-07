# Uncomment this line to define a global platform for your project

source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/MrTank1001/MTSpecRepository.git'


platform :ios, '9.0'

project 'Demo'

# SDK/组件使用的依赖（最后应该在podspec中体现）
def dependency

pod 'Masonry'
pod 'APPFrameworkKit', '0.1.0'

end

# 仅在开发时使用的依赖（不应该加入到podspec），如单元测试框架等
def develop_dependency

end

target 'Demo' do
    dependency
    develop_dependency

end
