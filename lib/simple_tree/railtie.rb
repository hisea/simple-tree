module SimpleTree
  class Railtie < Rails::Railtie
    initializer 'simple_tree' do
      ActiveSupport.on_load :active_record do
        extend SimpleTree::ClassMethods
      end
    end
  end
end