require 'spec_helper'

describe 'paper_icon_theme::install' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts.merge(
          desktop: { type: 'cinnamon' }
        )
      end

      context 'configure the moka ppa' do
        it { should contain_apt__ppa('ppa:snwh/pulp') }
      end

      context 'install paper with defaults' do
        it { should contain_package('paper-icon-theme').with_ensure('latest') }
      end

      context 'remove paper icon theme' do
        let :params do
          {
            package_ensure: 'absent'
          }
        end

        it { should contain_package('paper-icon-theme').with_ensure('absent') }
      end

      it { should contain_apt__ppa('ppa:snwh/pulp').that_notifies('Class[apt::update]') }
      it { should contain_package('paper-icon-theme').that_requires('Class[apt::update]') }
    end
  end
end
