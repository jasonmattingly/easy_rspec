# EasyRspec 
[![Maintainability](https://api.codeclimate.com/v1/badges/25a2889cda5d88e4d9df/maintainability)](https://codeclimate.com/github/jasonmattingly/easy_rspec/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/25a2889cda5d88e4d9df/test_coverage)](https://codeclimate.com/github/jasonmattingly/easy_rspec/test_coverage)
[![Gem Version](https://badge.fury.io/rb/easy_rspec.svg)](https://badge.fury.io/rb/easy_rspec)
[![build status](https://travis-ci.org/jasonmattingly/easy_rspec.svg?branch=master)](https://travis-ci.org/jasonmattingly/easy_rspec)

EasyRspec allows you to build an RSpec test file from scratch with a single command. The RSpec test file will be generated with:
1. A file path mirroring the path of the file being tested.

    **Original file path:** `app/models/users/customer.rb`

    **Generated test file path:** `spec/models/users/customer_spec.rb`
2. Correct headers describing the class being tested

    **Original file header:** `class Customer < ApplicationRecord`

    **Generated test file header:** `describe Customer do`
3. Describe blocks for instance and class methods found in the original file

    **Original file:**

    ```ruby
    class Customer < ApplicationRecord
      def name
        if first_name && last_name
          "#{first_name} #{last_name}"
        else
          "Lu Peachem"
        end
      end

      def self.has_account?
        false
      end
    end
    ```
    **Generated test file:**
    ```ruby
    describe Customer do
      describe '#name' do
        context '' do
          it '' do
          end
        end
      end

      describe '.has_account?' do
        context '' do
          it '' do
          end
        end
      end
    end
    ```
## Install
```ruby
gem install easy_rspec
```
Or add to your Gemfile:
```ruby
gem 'easy_rspec'
```
## Usage
Simply type `easy_rspec ClassName` into the console, where `ClassName` is the name of the class you'd like to create an RSpec test file for. If, for instance, the name of the class you'd like to create a test file for is `Customer`, you would type
```
easy_rspec Customer
```
and then press enter.

If a test file already exists at the expected RSpec file path, you will receive an error message and no file will be created nor will the pre-existing file be changed.

EasyRspec only generates tests for files that are located in your `app/` directory. If there are multiple files in your `app/` directory that match the class you requested, you will be asked to specify which file you were intending to create a test file for:
```
Which number represents your file path?
0. app/models/users/customer.rb
1. app/models/customer.rb
```
