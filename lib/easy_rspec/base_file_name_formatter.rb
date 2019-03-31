module EasyRspec
  class BaseFileNameFormatter

    def initialize(klass_name)
      @klass_name = stringify_klass_name(klass_name)
    end

    def klass_name
      @klass_name
    end

    def format
      "#{formatted_file_name}.rb"
    end

    private

    def stringify_klass_name(klass_name)
      klass_name == Class ? klass_name.name : klass_name.to_s
    end

    def formatted_file_name
      formatted_file_name_components.join('/')
    end

    def formatted_file_name_components
      klass_name_components.map{ |component| component.gsub(/(.)([A-Z])/,'\1_\2').downcase }
    end

    def klass_name_components
      @klass_name.split('::')
    end

  end
end
