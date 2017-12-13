require 'spec_helper'

describe 'paper_icon_theme' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      context 'with all required parameters' do
        let :facts do
          facts.merge(
            desktop: { type: 'cinnamon' }
          )
        end
        let :params do
          {
            user: 'testuser'
          }
        end
        let :pre_condition do
          [
            'user  { "testuser":  ensure => present }'
          ]
        end

        it { should compile.with_all_deps }
        it { should contain_class('paper_icon_theme') }
        it { should contain_class('paper_icon_theme::config').that_requires('Class[paper_icon_theme::install]') }
        it { should contain_class('paper_icon_theme::config').that_requires('User[testuser]') }
        it { should contain_class('paper_icon_theme::install') }
        it { should contain_class('paper_icon_theme::params') }
      end

      context 'user param not set' do
        let :facts do
          facts.merge(
            desktop: { type: 'cinnamon' }
          )
        end

        it do
          expect do
            subject.call
          end.to raise_error(Puppet::PreformattedError, /parameter 'user' expects a String value, got Undef/)
        end
      end

      context 'fact desktop type not defined' do
        let :params do
          {
            user: 'testuser'
          }
        end

        it do
          expect do
            subject.call
          end.to raise_error(Puppet::Error, /fact desktop.type is not defined, please ensure this fact is defined and run again/)
        end
      end

      context 'fact desktop type not supported' do
        let :facts do
          facts.merge(
            desktop: { type: 'unity' }
          )
        end
        let :params do
          {
            user: 'testuser'
          }
        end

        it do
          expect do
            subject.call
          end.to raise_error(Puppet::Error, /Desktop unity is not supported/)
        end
      end
    end
  end

  context 'with unsupported operatingsystem' do
    let :facts do
      {
        operatingsystem: 'Unsupported OS',
        desktop: { type: 'cinnamon' }
      }
    end

    it do
      expect do
        subject.call
      end.to raise_error(Puppet::Error, /Unsupported OS not supported/)
    end
  end
end
