# require 'spec_helper'

# describe Mineshaft::ActivateTemplate do
#   it "should create the template" do
#     FileUtils::mkdir_p 'template_test'
#     FileUtils::mkdir_p 'template_test/bin'

#     template_file = File.open(File.join(File.dirname(File.expand_path(__FILE__)), '../environment/activate.sh.erb'))
#     Mineshaft::ActivateTemplate.new('template_test', template_file).create

#     expect(File).to exist('template_test/bin/activate.sh')

#     FileUtils::rm_rf 'template_test'
#   end
# end