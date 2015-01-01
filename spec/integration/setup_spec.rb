require 'spec_helper'

describe 'Setup ROM from Virtus models' do
  it 'works' do
    class User
      include Virtus.value_object

      values do
        attribute :id, Integer
        attribute :name, String
        attribute :age, Integer
      end
    end

    setup = ROM.setup("memory://localhost/test")

    setup.from_virtus(User)

    rom = setup.finalize

    expect(rom.relations.users).not_to be(nil)

    rom.schema.users << { id: 1, name: 'Piotr', age: 31 }

    user = User.new(id: 1, name: 'Piotr', age: 31)

    expect(rom.read(:users)).to match_array([user])
  end
end
