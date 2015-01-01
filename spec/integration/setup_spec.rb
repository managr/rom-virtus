require 'spec_helper'

describe 'Setup ROM from Virtus models' do
  it 'works' do
    class User
      include Virtus.model

      attribute :id, Integer
      attribute :name, String
      attribute :age, Integer
    end
  end
end
