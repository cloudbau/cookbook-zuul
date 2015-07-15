name "zuul"
maintainer 'Jan Klare'
maintainer_email 'j.klare@cloudbau.de'
license 'Apache 2.0'
description 'Installs the Zuul job management service'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.3.3'

%w(ubuntu).each do |os|
  supports os
end

depends 'python'
depends 'git'
depends 'build-essential'
depends 'apache2'
