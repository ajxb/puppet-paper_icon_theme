require 'spec_helper'

describe 'paper_icon_theme::config' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      context 'configure paper with defaults' do
        let :params do
          {
            user: 'testuser'
          }
        end
        it do
          should contain_gnome__gsettings('desktop.interface_icon-theme').with(
            schema: 'org.gnome.desktop.interface',
            key:    'icon-theme',
            value:  '\'Paper\''
          )
        end
      end

      context 'configure paper for cinnamon' do
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
        it do
          should contain_gnome__gsettings('desktop.interface_icon-theme').with(
            schema: 'org.cinnamon.desktop.interface',
            key:    'icon-theme',
            value:  '\'Paper\''
          )
        end
      end

      context 'remove paper icon theme with defaults' do
        let :params do
          {
            package_ensure: 'absent',
            user:           'testuser'
          }
        end

        it do
          should contain_gnome__gsettings('desktop.interface_icon-theme').with(
            schema: 'org.gnome.desktop.interface',
            key:    'icon-theme',
            value:  '\'ubuntu-mono-dark\''
          )
        end
      end

      context 'configure paper for cinnamon' do
        let :facts do
          facts.merge(
            desktop: { type: 'cinnamon' }
          )
        end
        let :params do
          {
            package_ensure: 'absent',
            user:           'testuer'
          }
        end
        it do
          should contain_gnome__gsettings('desktop.interface_icon-theme').with(
            schema: 'org.cinnamon.desktop.interface',
            key:    'icon-theme',
            value:  '\'Mint-X\''
          )
        end
      end

      context 'user param not set' do
        it do
          expect do
            subject.call
          end.to raise_error(Puppet::PreformattedError, /parameter 'user' expects a String value, got Undef/)
        end
      end
    end
  end
end
