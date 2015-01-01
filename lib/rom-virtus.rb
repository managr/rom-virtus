require 'rom'
require 'virtus'

module ROM
  class Setup
    def from_virtus(virtus_model)
      name = Inflecto.pluralize(Inflecto.underscore(virtus_model.name.to_s)).to_sym
      attributes = virtus_model.attribute_set

      schema do
        base_relation(name) do
          repository :default

          attributes.each do |attr|
            attribute attr.name
          end
        end
      end

      relation(name)

      mappers do
        define(name) do
          model virtus_model
        end
      end
    end
  end
end
