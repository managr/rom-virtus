require 'spec_helper'

describe 'Setup ROM from Virtus models' do
  subject(:rom) { setup.finalize }

  let(:setup) { ROM.setup("memory://localhost/test") }

  it 'works' do
    class User
      include Virtus.value_object

      values do
        attribute :id, Integer
        attribute :name, String
        attribute :age, Integer
      end
    end

    setup.from_virtus(User)

    expect(rom.relations.users).not_to be(nil)

    tuple = { id: 1, name: 'Piotr', age: 31 }
    user = User.new(tuple)

    rom.schema.users << tuple

    expect(rom.read(:users)).to match_array([user])
  end
end
