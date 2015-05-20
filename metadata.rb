name "zuul"
maintainer 'Edmund Haselwanter'
maintainer_email 'team@infralovers.com'
license 'Apache 2.0'
description 'Installs the Zuul Gerrit/Jenkins job management service'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.3.0'

%w(ubuntu).each do |os|
  supports os
end

depends 'python'
depends 'git'
depends 'build-essential'
