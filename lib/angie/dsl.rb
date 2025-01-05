# frozen_string_literal: true

module Angie
  class DSL
    def initialize(parent = nil, &block)
      @config = []
      @parent = parent
      @indentation = parent ? parent.indentation + 1 : 0
      instance_exec(&block) if block_given?
    end

    def directive(name, *args)
      @config << "#{indent}#{name} #{args.join(' ')};"
    end

    def block(name, &block)
      @config << "#{indent}#{name} {"
      if block_given?
        child = Angie::DSL.new(self, &block)
        @config.concat(child.config)
      end
      @config << "#{indent}}"
    end

    def method_missing(name, *args, &block)
      if block_given?
        block(name.to_s, &block)
      else
        directive(name.to_s, *args)
      end
    end

    def respond_to_missing?(method_name, include_private = false)
      true
    end

    def config
      @config
    end

    def to_s
      @config.join("\n") unless @parent
    end

    protected
      attr_reader :indentation

    private
      def indent
        '  ' * @indentation
      end
  end
end