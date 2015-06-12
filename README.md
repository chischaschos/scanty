# Scanty, a really small blog

[![Build Status](https://snap-ci.com/chischaschos/scanty/branch/master/build_image)](https://snap-ci.com/chischaschos/scanty/branch/master)
[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/chischaschos/scanty)

## Overview

Original [scanty
readme](https://github.com/chischaschos/scanty/blob/master/README.rdoc), but a
few changes:

- Simplified views and coverted them to HAML
- Added specs and fixed test suite
- Updated gems
- Added sprockets
- Added [foundation](http://foundation.zurb.com/)
- Uses [kramdown](https://github.com/gettalong/kramdown) instead of
[maruku](https://github.com/bhollis/maruku/). It is faster and has
better support for embedded html
- Uses [puma](https://github.com/puma/puma)
- Contains provisioning support via [Ansible](http://www.ansible.com/home),
[Vagrant](http://www.vagrantup.com/) and [Capistrano](http://capistranorb.com/)

Made some changes to the default code base in
order to remove empty spaces, fix test suite, upgrade used gems and
customize its configuration.

## Priority fixes

- Server static content fast
- Serve all fast
- Serve multiple requests fast
- Generated markup styles
- Decoupling post model business logic

## Just for fun roadmap:

- Post review history
- Responsive layouts
- Full JS app consuming API

## Provisioning

- Based on https://github.com/radar/ansible-rails-app
- Tips from http://ruby-journal.com/how-to-setup-rails-app-with-puma-and-nginx/
- Depending on https://github.com/dotless-de/vagrant-vbguest

1. Copy provisioning/vars/defaults.yml.example to provisioning/vars/defaults.yml
2. Set you deploy public key in [deploy_public_key](provisioning/vars/defaults.yml)
3. Run ```vagrant up```
4. Run ```cap staging deploy```
