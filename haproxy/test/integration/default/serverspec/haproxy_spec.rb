require 'serverspec'

# Required by serverspec
set :backend, :exec
describe 'haproxy' do
  it 'is listening on port 80' do
    expect(port(80)).to be_listening
  end
  it 'has a running service of haproxy' do
    expect(service('haproxy')).to be_running
  end
end
